import Vapor
import Fluent

struct userinfoController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let userInfos = routes.grouped("user")
        userInfos.get(use: getUserinfo)
        userInfos.get("main",use: getMaininfo)
        userInfos.put(use: updateUserinfo)
        userInfos.put("weight", use: updateUserWeight)
        userInfos.post("register", use: registerUser)
        userInfos.get("login", use:loginUser)
    }
    
    //create user information
    func createUserinfo(req: Request, userid: Int, username: String) throws -> EventLoopFuture<Void> {
        let newuser = userinfo(id:userid, username: username, gender: "male", age: 0, height: 0, weight: 0, target: 0, calories: 0)
        return newuser.create(on: req.db)
    }
    
    func createUserpref(req: Request, userid: Int) throws -> EventLoopFuture<Void> {
        let newpref = userpref(id:userid, breakfast: 0, lunch: 0, dinner: 0, snack: 0, dislike: [], allergies: [])
        return newpref.create(on: req.db)
    }
    func createUser(req: Request, name: String, pw: String) throws -> EventLoopFuture<Void>{
        let pwd = try Bcrypt.hash(pw)
        let newuser = user(username: name, password: pwd)
        return newuser.create(on: req.db)
    }
    
    
    struct userId: Content{
        let userid: Int
    }
    //get user info
    func getUserinfo(req: Request) throws -> EventLoopFuture<userinfo> {
        let UserId = try req.content.decode(userId.self)
        let userid = UserId.userid
        return userinfo.find(userid, on: req.db).map{ info in
            return info!}
    }
    
    //update user information
    func updateUserinfo(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let userInfo = try req.content.decode(userinfo.self)
        userInfo.calories = caloriesCalclator(age: userInfo.age!, gender: userInfo.gender!, height: userInfo.height!, weight: userInfo.weight, target: userInfo.target)
        return userinfo.find(userInfo.id!, on: req.db).flatMap{ newUser -> EventLoopFuture<HTTPStatus> in
            if nil == newUser {
                return userinfo.find(userInfo.id!, on: req.db).transform(to: .noContent)
            }
            newUser!.id = userInfo.id
            newUser!.age = userInfo.age
            newUser!.gender = userInfo.gender
            newUser!.height = userInfo.height
            newUser!.weight = userInfo.weight
            newUser!.target = userInfo.target
            newUser!.calories = userInfo.calories
            //newUser!.username = userInfo.username
            return newUser!.update(on: req.db).transform(to: .ok)
        }
    }
    
    //update user weight and target
    func updateUserWeight(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let userInfo = try req.content.decode(userinfo.self)
        
        return userinfo.find(userInfo.id!, on: req.db).flatMap{ newUser -> EventLoopFuture<HTTPStatus> in
            if nil == newUser {
                return userinfo.find(userInfo.id!, on: req.db).transform(to: .noContent)
            }
            
            newUser!.id = userInfo.id
            newUser!.weight = userInfo.weight
            newUser!.target = userInfo.target
            newUser!.calories = caloriesCalclator(age: newUser!.age!, gender: newUser!.gender!, height: newUser!.height!, weight: newUser!.weight, target: newUser!.target)
            return newUser!.update(on: req.db).transform(to: .ok)
        }
    }
    
    func registerUser(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let userRegister = try req.content.decode(user.self)
        return user.query(on: req.db)
            .filter(\.$username == userRegister.username)
            .first()
            .flatMap{ userFound -> EventLoopFuture<HTTPStatus> in
                if nil == userFound {
                    print("not exists")
                    do {
                        let _ = try createUser(req: req, name: userRegister.username, pw: userRegister.password)
                    }catch _ {
                        print("fail to create user")
                    }
                    return user.query(on: req.db)
                        .filter(\.$username == userRegister.username)
                        .first()
                        .flatMap{ userCreated in
                            do {
                                let _ = try createUserinfo(req: req, userid: userCreated!.id ?? -1, username: userCreated!.username)
                                let _ = try createUserpref(req: req, userid: userCreated!.id ?? -1)
                            }catch _{
                                print("failed created info or pref")
                            }
                            return userCreated!.save(on: req.db).transform(to: .ok)
                        }
                }
                else {
                    print("exists")
                    return userFound!.save(on: req.db).transform(to: .conflict)
                }
            }
    }
    
    func loginUser(req: Request) async throws -> user {
        let userLogin = try req.content.decode(user.self)
        //print(userLogin)
        let wrongpwd = user(id:-1 ,username: userLogin.username, password: userLogin.password)
        let userFound = try await user.query(on: req.db).filter(\.$username == userLogin.username).first()
        if userFound != nil{
            let pass = try Bcrypt.verify(userLogin.password, created: userFound!.password)
            if pass{
                return userFound!
            }
            return wrongpwd
        }
        return wrongpwd
    }
    
    func getMaininfo(req: Request) throws -> EventLoopFuture<info> {
        let UserId = try req.content.decode(userId.self)
        let userid = UserId.userid
        let main = try getUserinfo(req: req).map{ currenti in
            let maininfo = info(userid: currenti.id, username: currenti.username, weight: currenti.weight, target: currenti.target, calories: currenti.calories,taken:0, foodlist: [])
            return maininfo
        }
        let newmain = main.flatMap{ main in
            let currentdata = fooddata.query(on: req.db).filter(\.$date == getdate()[0]).filter(\.$userid == userid).all()
            //print(currentdata)
            let foodlist = currentdata.map{ current in
                var cls:[Int] = []
                for d in current{
                    let cl = d.checked!
                    cls = cls + cl
                }
                return cls
            }
            let maini = foodlist.flatMap{ fl in
                do {
                    print(fl)
                    let result = try getSum(req: req, foodlist: fl)
                    //let checked = try getFoodlist(req: req, foodlist: fl, checked: fl)
                    
                    return result.map{ result in
                        return info(userid: main.userid, username: main.username, weight: main.weight, target: main.target, calories: main.calories, taken:result)
                    }
                }catch{
                    return req.eventLoop.makeFailedFuture(error)
                }
            }
            let mainii = maini.flatMap{ maini in
                let mainfinal = foodlist.flatMap{ fl in
                    do{
                        let checked = try getFoodlist(req: req, foodlist: fl, checked: fl)
                        return checked.map{ checked in
                            return info(userid: maini.userid, username: maini.username, weight: maini.weight, target: maini.target, calories: maini.calories, taken:maini.calories, foodlist:checked)
                        }
                    }catch{
                        return req.eventLoop.makeFailedFuture(error)
                    }
                }
                return mainfinal
            }
            return mainii
        }
        return newmain
    }
    
    
    //get current date time and tag
    func getdate() ->[String]{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        //get current date
        let currentDate = dateFormatter.string(from: Date())
        dateFormatter.dateFormat = "HH"
        let time = Date()
        //get current hour
        let currentTime = dateFormatter.string(from: time)
        
        var tag:String
        if Int(currentTime) ?? 0 >= 5 && Int(currentTime) ?? 0 <= 10 {
            tag = "breakfast"
        }
        else if Int(currentTime) ?? 0 > 10 && Int(currentTime) ?? 0 <= 13{
            tag = "lunch"
        }
        else if Int(currentTime) ?? 0 > 16 && Int(currentTime) ?? 0 <= 20{
            tag = "dinner"
        }
        else{
            tag = "snack"
        }
        print(currentDate,currentTime,tag)
        return [currentDate, currentTime, tag]
    }
    
    // get food list
    func getFoodlist(req: Request, foodlist: [Int], checked:[Int]) throws -> EventLoopFuture<[Checkfood]> {
        return Meal.query(on: req.db)
                .filter(\.$id ~~ foodlist)
                .all()
                .map{ meallist in
                    var cfs:[Checkfood] = []
                    for m in meallist {
                        var mealchecked = 0
                        if checked.contains(m.id!){
                            mealchecked = 1
                        }
                        let cf = Checkfood(name: m.name, foodid: m.id, contains: m.contains, calories: m.calories, checked: mealchecked)
                        cfs.append(cf)
                    }
                    return cfs
                }
    }
    
    // get cal sum
    func getSum(req: Request, foodlist: [Int]) throws -> EventLoopFuture<Int> {
        return Meal.query(on: req.db)
                .filter(\.$id ~~ foodlist)
                .all()
                .map { meals in
                    return meals.reduce(0) { $0 + ($1.calories) }
                }
    }
    
}
