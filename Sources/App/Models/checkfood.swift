class checkfood{
    
    var id: Int!
    
    var name: String?
    
    var foodid: Int!
    
    var calories: Int?
    
    var checked: Int?
    
    init(id: Int!, name: String? = nil, foodid: Int!, calories: Int? = nil , checked: Int? = nil) {
        self.id = id
        self.name = name
        self.foodid = foodid
        self.calories = calories
        self.checked = checked
    }
}
