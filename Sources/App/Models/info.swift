import Vapor
//userid= 用户id int
//username=用户名称 string
//weight =当前体重 float
//target =目标体重 float
//calories= 当前推荐卡路里 int
//taken=当前已摄入卡路里 int
//foodlist = 当日check过的食物 list of food object
final class info:Content{
    
    var userid: Int!
    
    var username: String?
    
    var weight: Double?
    
    var target: Double?
    
    var calories: Int?
    
    var taken: Int?
    
    var foodlist: [Checkfood]?
    
    init(userid: Int!, username:String? = nil, weight: Double? = nil, target: Double? = nil, calories: Int? = nil, taken: Int? = nil,foodlist:[Checkfood]? = nil) {
        self.userid = userid
        self.username = username
        self.weight = weight
        self.target = target
        self.calories = calories
        self.taken = taken
        self.foodlist = foodlist
    }
}
