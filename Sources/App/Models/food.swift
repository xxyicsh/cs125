//foodid int
//name string
//Tag = ‘breakfast’, lunch, dinner ,snack  string
//contains  list of string
//calories int
import Foundation
import Fluent
import Vapor


final class food: Model, Content {
    
    static let schema = "food"

    @ID(custom: "foodid")
    var id: Int?

    @Field(key: "name")
    var name: String
    
    @Field(key: "tag")
    var tag: String
    
    @Field(key: "contains")
    var contains: [String]
    
    @Field(key: "calories")
    var calories: Int
    
    
    init() {}

    init(id: Int? = nil, name: String, tag: String, contains: [String], calories: Int) {
        self.id = id
        self.name = name
        self.tag = tag
        self.contains = contains
        self.calories = calories
    }
}

