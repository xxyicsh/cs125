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

    @ID(custom: "userid")
    var id: Int?
    
    @Timestamp(key: "date", on: .create)
    var date: Date?

    @Field(key: "meal")
    var meal: String
    
    @Field(key: "recommend")
    var recommend: [Int]?
    
    @Field(key: "checked")
    var checked: [Int]?
    
    init() {}

    init(id: Int? = nil, date: Date? = nil, meal: String, recommend: [Int]? = nil, checked: [Int]? = nil) {
        self.id = id
        self.date = date
        self.meal = meal
        self.recommend = recommend
        self.checked = checked
    }
}

