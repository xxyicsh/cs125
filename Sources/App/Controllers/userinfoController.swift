import Vapor
import Fluent

struct userinfoController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let userInfos = routes.grouped("user")
        userInfos.get(use: getUserinfo)
        userInfos.post(use: createUserinfo)
        userInfos.put(use: updateUserinfo)
        userInfos.put("weight", use: updateUserWeight)
    }
    
    //create user information
    func createUserinfo(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let userInfo = try req.content.decode(userinfo.self)
        return userInfo.create(on: req.db)
            .transform(to: .ok)
    }
    
    //get user information
    func getUserinfo(req: Request) throws -> EventLoopFuture<userinfo> {
        let a = userinfo.query(on: req.db).all().map { infos in
            return infos[0]
        }
        return a
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
            newUser!.username = userInfo.username
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

}
