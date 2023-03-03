//
//  MealController.swift
//  
//
//  Created by Weiyu Hao on 2/28/23.
//

import Vapor
import Fluent

struct MealController: RouteCollection {
    func boot(routes: Vapor.RoutesBuilder) throws {
        //let breakfast = routes.grouped("breakfast")
//        breakfast.group(":name"){
//            breakfast in breakfast.get(use: getByName)
//        }
        //breakfast.get(use: getByName)
        routes.get(use: index)
        routes.get("name", use: getByName)
        routes.get("calories", use: getByCal)
        
    }
    
    // /user route
    func index(req: Request) throws -> EventLoopFuture<[Meal]> {
        return Meal.query(on: req.db).all()
    }
    
    // GET Request /name
    func getByName(req: Request) throws ->EventLoopFuture<[Meal]> {
        let foodname = try req.parameters.require("name")
        return Meal.query(on: req.db)
            .filter(\.$name == foodname)
                    .all()
                    //.unwrap(or: Abort(.notFound))
    
    }
    
    // GET Request /calories
    func getByCal(req: Request) throws ->EventLoopFuture<[Meal]> {
        guard let maxCalories = req.query[Int.self, at: "calories"] else {
                throw Abort(.badRequest, reason: "Missing 'calories' parameter")
            }
            return Meal.query(on: req.db)
                .filter(\.$calories <= maxCalories)
                .all()
    
    }
    
}

