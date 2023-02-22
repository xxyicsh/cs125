import Vapor
import Fluent

struct fooddataController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let fooddatas = routes.grouped("food")
//        fooddatas.get(use: getFooddata)
//        fooddatas.put(use: updateFooddata)

    }
    
    
// //uncomment to edit-------------------
    
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
//    func updateFooddata(req: Request) throws -> EventLoopFuture<HTTPStatus> {
//        //1. decode req.content to checkfood object
//        //2. get fooddata by current date and tag from fooddata table;
//        //         if not found return 204 no content
//        //3. update fooddata object, add checkfood.foodid to fooddata.checked list
//        //4. update fooddata onject on db, return 200 ok
//
//    }
//
//
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
