//Table 3: fooddata
//userid: 用户id主键 int
//date: 日期 date
//meal: 食物类型 string (“breakfast“ or ‘“lunch” or “dinner” or “snack”)
//recommend: 推荐食品列表 [list of foodid]
//checked:  [list of foodid]
import Foundation
import Fluent
import Vapor


final class fooddata: Model, Content {
    
    static let schema = "fooddata"

    @ID(custom: "fooddataid")
    var id: Int?
    
    @Field(key: "userid")
    var userid: Int?
    
    @Field(key:"date")
    var date: String?

    @Field(key: "meal")
    var meal: String
    
    @Field(key: "recommend")
    var recommend: [Int]?
    
    @Field(key: "checked")
    var checked: [Int]?
    
    init() {}

    init(id: Int? = nil, userid: Int? = nil,date: String? = nil, meal: String, recommend: [Int]? = nil, checked: [Int]? = nil) {
        self.id = id
        self.userid = userid
        self.date = date
        self.meal = meal
        self.recommend = recommend
        self.checked = checked
    }
}

