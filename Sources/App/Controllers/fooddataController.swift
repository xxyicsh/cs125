import Vapor
import Fluent

struct fooddataController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let fooddatas = routes.grouped("food")
        fooddatas.get(use: getFooddata)
        //        fooddatas.put(use: updateFooddata)
        
    }
    
    
    // //uncomment to edit-------------------
    func getFooddata(req: Request) throws -> EventLoopFuture<[Int]> {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "America/Los_Angeles")!
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.date(from: dateFormatter.string(from: Date())) ?? Date()
        dateFormatter.dateFormat = "HH"
        let time = Date()
        let currentTime = dateFormatter.string(from: time)
        var tag = "breakfast"
        if Int(currentTime) ?? 0 >= 9 && Int(currentTime) ?? 0 <= 12 {
            tag = "lunch"
        }
        else if Int(currentTime) ?? 0 > 12 && Int(currentTime) ?? 0 <= 18{
            tag = "dinner"
        }
        else{
            tag = "snack"
        }
        print(time,tag)
        
        return fooddata.query(on: req.db)
            .filter(\.$date == currentDate)
            .filter(\.$meal == tag)
            .first()
            .flatMap { foodData in
                do{
                    if let foodData = foodData {
                        print("exists")
                        // foodData exists, so return the list of recommended foods
                        return req.eventLoop.makeSucceededFuture(foodData.checked ?? [])
                        //foodData.checked ?? []
                        //                                .all()
                        
                    } else {
                        // foodData does not exist, so create it and return the list of recommended foods
                        print("not exists")
                        return try createFooddata(req: req, currentDate: currentDate, tag: tag)
                            .flatMap { foodData in
                                return req.eventLoop.makeSucceededFuture(foodData.checked ?? [])
                                //                                    return fooddata.query(on: req.db)
                                //                                        .filter(\.$id ~~ recommendedFoodIDs)
                                //                                        .all()
                            }
                    }
                } catch{
                    return req.eventLoop.makeFailedFuture(error)
                }
            }
    }
    
    //    //get fooddata which return list of food to app
    //    func getFooddata(req: Request) throws -> EventLoopFuture<[food]> {
    //        //1. try get fooddata by current date and tag from fooddata table
    //        //2. if not found, call createFooddata function.
    //        //3. createFooddata function will return fooddata object
    //        //4. use fooddata.recommend and fooddata.checked to generate list of checkfood objects
    //        //5. return list of checkfood
    //
    //    }
    //
    //
    //    //update checked on db
    
    struct CheckRequest: Content{
        let id: Int
        let foodId: Int
    }
    
    func updateFooddata(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        //var checked = try getFooddata(req: req)
        let checkRequest = try req.content.decode(CheckRequest.self)
        let id = checkRequest.id
        let foodId = checkRequest.foodId
        
        return try getFooddata(req: req)
            .flatMap{ checked -> EventLoopFuture<HTTPStatus> in
                var checkedList = checked
                checkedList.append(foodId)
                
                return fooddata.query(on: req.db)
                    .filter(\.$id == id)
                //                    .filter(\.$date == currentDate)
                //                    .filter(\.$meal == tag)
                    .first()
                    .unwrap(or: Abort(.notFound))
                    .flatMap { foodData in
                        // Update the checked list of the corresponding fooddata object
                        foodData.checked = checkedList
                        
                        // Save the updated fooddata object in the database
                        return foodData.save(on: req.db)
                            .transform(to: .ok)
                    }
            }
    }
//        var checked = try getFooddata(req: req)
//        let result = checked.map { checkedArray -> EventLoopFuture<HTTPStatus> in
//            if !checkedArray.isEmpty{
//                checked.flatMap { checked in
//                    var newChecked = checked
//                    newChecked.append(foodId)
//                    fooddata.checked = newChecked
//                    fooddata.update(on: req.db).transform(to: ())
//                }
//                return req.eventLoop.makeSucceededFuture(.ok)
//            } else {
//                return req.eventLoop.makeSucceededFuture(.noContent)
//            }
//        }
       
    
    
    
    //1. decode req.content to checkfood object
    //2. get fooddata by current date and tag from fooddata table;
    //         if not found return 204 no content
    //3. update fooddata object, add checkfood.foodid to fooddata.checked list
    //4. update fooddata onject on db, return 200 ok
    
    //
    //
    
    func createFooddata(req: Request, currentDate: Date, tag: String) throws -> EventLoopFuture<fooddata> {
        let fooddata = fooddata()
        fooddata.id = 1
        fooddata.meal = tag
        fooddata.recommend = [] // call recom function
        fooddata.checked = []
        return fooddata.save(on: req.db).map { _ in
                return fooddata
            }
        //return req.eventLoop.makeSucceededFuture(fooddata)
    }
    //    //create fooddata to table and return the created object
    //    func createFooddata() throws -> EventLoopFuture<fooddata> {
    //        //1. initalize fooddata object
    //        //      fooddata.id = 1
    //        //      fooddata.data (this timestamp is auto)
    //        //      fooddata.meal = (based on current time for breakfast lunch or dinner)
    //        //      fooddata.recommend = (call recommendation function)
    //        //      fooddata.checked = [] (empty list of string)
    //        //2. save object on database
    //        //3. return object
    //    }
    
    // // uncomment to edit-------------------
    
}
