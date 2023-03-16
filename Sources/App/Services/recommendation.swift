//
// function of recommendation system which generate list of foodid
// need design and develop
// currently return top 10 food id

import Foundation
import Vapor
import Fluent

func recommendation(req: Request, user_id: Int, current_time: String, current_date: String) throws -> EventLoopFuture<[Int]> {
    let user: EventLoopFuture<info> = userinfo.find(user_id, on: req.db).flatMap{ currentinfo in
        do{
            let taken = try getTaken(req: req, user_id: user_id, current_date: current_date)
            return taken.map{ t in
                var newinfo: info = info(userid: user_id)
                newinfo.calories = currentinfo!.calories
                newinfo.taken = t
                return newinfo
            }
        }catch{
            return req.eventLoop.makeFailedFuture(error)
        }
    }
    
    let user_pref: EventLoopFuture<userpref> = userpref.find(user_id, on: req.db).map{u in u!}
    let combined = user.and(user_pref)
    print("In rec")
    return combined.flatMap {
        user, user_pref in
        // if not preferred, return empty array
        print(current_time)
        if ((current_time == "breakfast" && (user_pref.breakfast == 0))
            || (current_time == "lunch" && (user_pref.lunch == 0))
            || (current_time == "dinner" && (user_pref.dinner == 0))
            || (current_time == "snack" && (user_pref.snack == 0))) {
            print("No need")
            return req.eventLoop.makeSucceededFuture([Int]())
        }
        return Meal.query(on: req.db)
            .filter(\.$name !~ user_pref.dislike)
            .filter(\.$name !~ user_pref.allergies)
            .all()
            .map {
                foods in
                
                let timeSlot: Int = user_pref.breakfast + user_pref.lunch + user_pref.dinner + user_pref.snack
                print(user.calories!)
                print(user.taken!)
                let recCalories: Int = (user.calories! - user.taken!) / timeSlot
                
               
                let sorted_foods: [Int] = foods.sorted { food1, food2 in
                    abs(recCalories - food1.calories) < abs(recCalories - food2.calories)
                }.map {
                    food in
                    food.id!
                }
                let rangeSize = recCalories/10
                //print(recCalories,rangeSize)
                var ranges = [ClosedRange<Int>]()
                var rangeStart = 0
                for _ in 1...10 {
                    let rangeEnd = rangeStart + rangeSize
                    let range = rangeStart...rangeEnd
                    ranges.append(range)

                    rangeStart = rangeEnd + 1
                }

                var rangeFoods: [ClosedRange<Int>: [Int]] = [:]

                for range in ranges {
                    rangeFoods[range] = []
                }

                for range in ranges {
                    for foodID in sorted_foods {
                        let foodCalories = foods.first { $0.id == foodID }?.calories ?? 0
                        if range.contains(foodCalories) {
                            print(range," contains ", foodID)
                            rangeFoods[range]?.append(foodID)
                            break
                        }
                    }
                }
            

                var result: [Int] = []

                for range in ranges {
                    if let foods = rangeFoods[range], !foods.isEmpty {
                        result.append(contentsOf: foods)
                    } else {
                        let closestRange = ranges.min(by: { abs($0.lowerBound - range.lowerBound) < abs($1.lowerBound - range.lowerBound) })!
                        let closestFoods = rangeFoods[closestRange] ?? []
                        let numToAdd = min(10 - result.count, closestFoods.count)
                        result.append(contentsOf: closestFoods.prefix(numToAdd))
                        //print(result)
                    }

                    if result.count >= 10 {
                        break
                    }
                }
                if result.count < 10 {
                    let remainingCount = 10 - result.count
                    let remainingFoods = sorted_foods.filter { foodID in
                        let foodCalories = foods.first { $0.id == foodID }?.calories ?? 0
                        return foodCalories > recCalories
                    }.prefix(remainingCount)

                    result.append(contentsOf: remainingFoods)
                }
                return result
                //return Array(sorted_foods[0..<10])
            }
    }
}

func getSum(req: Request, foodlist: [Int]) throws -> EventLoopFuture<Int> {
    return Meal.query(on: req.db)
            .filter(\.$id ~~ foodlist)
            .all()
            .map { meals in
                var mealDict: [Int: Meal] = [:]
                for meal in meals {
                    mealDict[meal.id ?? 1] = meal
                }
                return foodlist.reduce(0) { $0 + (mealDict[$1]?.calories ?? 0) }
            }
}

func getTaken(req: Request, user_id: Int, current_date: String) throws -> EventLoopFuture<Int> {
    let currentdata = fooddata.query(on: req.db).filter(\.$date == current_date).filter(\.$userid == user_id).all()

    let foodlist = currentdata.map{ current in
        var cls:[Int] = []
        for d in current{
            let cl = d.checked!
            cls = cls + cl
        }
        return cls
    }
    let taken = foodlist.flatMap{ fl in
        do {
            print(fl)
            let result = try getSum(req: req, foodlist: fl)
            return result
        }catch{
            return req.eventLoop.makeFailedFuture(error)
        }
    }
    return taken
}
