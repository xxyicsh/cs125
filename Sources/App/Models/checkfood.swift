import Vapor
final class Checkfood:Content{
    
    var name: String!
    
    var foodid: Int!
    
    var contains: [String]!
    
    var calories: Int!
    
    var checked: Int!
    
    init(name: String!, foodid: Int!, contains:[String]!,calories: Int!, checked: Int!) {
        self.name = name
        self.foodid = foodid
        self.contains = contains
        self.calories = calories
        self.checked = checked
    }
}
