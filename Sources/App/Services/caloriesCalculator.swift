import Foundation
//calculate calories based on informations

func caloriesCalclator(age:Int, gender:String, height:Int, weight:Double, target:Double) -> Int{
    //basic input required
    var base:Double
    //weight gap
    let gap = weight - target
    //target period 90 days
    let period = 90
    
    //get base calories
    if gender == "male" {
        base = 660 + (14 * weight) + (5 * Double(height)) - (7 * Double(age))
    }else{
        base = 600 + (10 * weight) + (2 * Double(height)) - (5 * Double(age))
    }
    print(base)
    let output = base - (7700 * gap / Double(period))
    print(output)
    return Int(output)
}
