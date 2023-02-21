import Foundation
import Fluent
import Vapor

//Table 2: userpref
//userid: 用户id主键 int
//breakfast: 是否需要推荐早餐 TF
//lunch： 是否需要推荐午餐 TF
//dinner：是否需要推荐晚餐 TF
//snack：是否需要推荐点心 TF
//dislike： 不喜欢的事物 list of string
//allergies: 过敏的食物 list of string


final class userpref: Model, Content {
    
    static let schema = "userpref"

    @ID(custom: "userid")
    var id: Int?

    @Field(key: "breakfast")
    var breakfast: Int

    @Field(key: "lunch")
    var lunch: Int
    
    @Field(key: "dinner")
    var dinner: Int
    
    @Field(key: "snack")
    var snack: Int
    
    @Field(key: "dislike")
    var dislike: [String]
    
    @Field(key: "allergies")
    var allergies: [String]
    
    init() {}

    init(id: Int? = nil, breakfast: Int, lunch: Int, dinner: Int, snack: Int, dislike: [String], allergies: [String]) {
        self.id = id
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.snack = snack
        self.dislike = dislike
        self.allergies = allergies
    }
}
