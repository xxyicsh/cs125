import Vapor
import Fluent

struct fooddataController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let fooddatas = routes.grouped("food")
        fooddatas.get(use: getrecommend)
        fooddatas.put(use: updateFooddata)
        
    }
    
    struct userId: Content{
        let userid: Int
    }
    
    //get recommend meal list
    func getrecommend(req: Request) throws -> EventLoopFuture<[Checkfood]> {
        let UserId = try req.content.decode(userId.self)
        let userid = UserId.userid
        return try getFooddata(req: req, userid: userid).flatMap{ foodData in
            do{
                return try getFoodlist(req: req, foodlist: foodData.recommend ?? [], checked: foodData.checked ?? [])
            }catch{
                return req.eventLoop.makeFailedFuture(error)
            }
        }
    }
    
    //get food data record
    func getFooddata(req: Request, userid:Int) throws -> EventLoopFuture<fooddata> {
        let current = getdate()
        let currentDate = current[0]
        let tag = current[2]
        

        return fooddata.query(on: req.db)
            .filter(\.$date == currentDate)
            .filter(\.$meal == tag)
            .filter(\.$userid == userid)
            .first()
            .flatMap { foodData in
                do{
                    if nil != foodData {
                        print("exists")
                        // foodData exists, so return the list of recommended foods
                        return fooddata.query(on: req.db)
                            .filter(\.$date == currentDate)
                            .filter(\.$meal == tag)
                            .filter(\.$userid == userid)
                            .first().map{ foodData in
                                return foodData!
                            }
                    } else {
                        // foodData does not exist, so create it and return the list of recommended foods
                        print("not exists")
                        return try createFooddata(req: req, tag: tag, id: userid)
                    }
                } catch{
                    return req.eventLoop.makeFailedFuture(error)
                }
            }
    }
    
    
    struct CheckRequest: Content{
        let id: Int
        let foodid: Int
    }
    
    //update checked list
    func updateFooddata(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let checkRequest = try req.content.decode(CheckRequest.self)
        let id = checkRequest.id
        let foodId = checkRequest.foodid
        let time = getdate()

        return fooddata.query(on: req.db)
            .filter(\.$date == time[0])
            .filter(\.$meal == time[2])
            .filter(\.$userid == id)
            .first()
            .flatMap{ foodData in
                var check = foodData!.checked ?? []
                if !check.contains(foodId){
                    check.append(foodId)
                }
                foodData!.checked = check
                //print(foodData?.checked,foodData?.date,foodData?.meal)
                return foodData!.update(on: req.db).transform(to: .ok)
            }
    }
       

    //create food data on mysql
    func createFooddata(req: Request, tag: String, id: Int) throws -> EventLoopFuture<fooddata> {
        let fooddata = fooddata()
        fooddata.userid = id
        fooddata.meal = tag
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        fooddata.date = currentDate
        fooddata.checked = []
        return try recommendation(req: req, user_id: id, current_time: tag).flatMap {
            rec in
            fooddata.recommend = rec
            return fooddata.save(on: req.db).map { _ in
                    return fooddata
            }
        }
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
    // TODO: same food different time checked are ignored. only one shows.
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
    
}
