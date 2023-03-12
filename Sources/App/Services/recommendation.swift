//
// function of recommendation system which generate list of foodid
// need design and develop
// currently return top 10 food id

import Foundation
import Vapor
import Fluent

func recommendation(req: Request, user_id: Int, current_time: String) throws -> EventLoopFuture<[Int]> {
    let user: EventLoopFuture<userinfo> = userinfo.find(user_id, on: req.db).map{u in u!}
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
                let recCalories: Int = user.calories! / timeSlot
                
               
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
