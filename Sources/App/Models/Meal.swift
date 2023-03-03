//
//  Meal.swift
//
//
//  Created by Weiyu Hao on 2/28/23.
//
import Fluent
import Vapor
import FluentMySQLDriver

final class Meal: Model, Content {
    static let schema = "meal"
    
    @ID(custom: .id)
    var id: Int?
    
    @Field(key: "tag")
    var tag: String
    
    @Field(key: "name")
    var name: String
    
    @Field(key: "contains")
    var contains: [String]
    
    @Field(key: "calories")
    var calories: Int
    
    
    init() {}
    //id: UUID? = nil,
    init(id: Int, tag: String, name: String, contains: [String], calories: Int) {
        self.id = id
        self.tag = tag
        self.name = name
        self.contains = contains
        self.calories = calories
    }
}
