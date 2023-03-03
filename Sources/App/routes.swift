import Vapor

func routes(_ app: Application) throws {
    
    //register userinfo controller
    try app.register(collection: userinfoController())
    
    try app.register(collection: userprefController())
    
    try app.register(collection: fooddataController())
    try app.register(collection: MealController())
}
