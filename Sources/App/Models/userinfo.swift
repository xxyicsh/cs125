import Foundation
import Fluent
import Vapor

//2: user database
//Table 1 userinfo
//userid：用户id主键 int
//username：用户名称 string
//gender：性别 string
//age：年龄 int
//height：身高 int
//weight：当前体重 float
//target：目标体重 float
//calories: 当前推荐卡路里 int


final class userinfo: Model, Content {
    
    static let schema = "userinfo"

    @ID(custom: "userid")
    var id: Int?

    @Field(key: "username")
    var username: String?

    @Field(key: "gender")
    var gender: String?
    
    @Field(key: "age")
    var age: Int?
    
    @Field(key: "height")
    var height: Int?
    
    @Field(key: "weight")
    var weight: Double
    
    @Field(key: "target")
    var target: Double
    
    @Field(key: "calories")
    var calories: Int?
    
    init() {}

    init(id: Int? = nil, username: String? = nil,  gender: String? = nil, age: Int? = nil, height: Int? = nil, weight: Double, target: Double, calories: Int? = nil) {
        self.id = id
        self.username = username
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
        self.target = target
        self.calories = calories
    }
}
