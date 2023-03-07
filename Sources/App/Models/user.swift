import Foundation
import Fluent
import Vapor


final class user: Model, Content {
    
    static let schema = "user"

    @ID(custom: "userid")
    var id: Int?

    @Field(key: "username")
    var username: String

    @Field(key: "password")
    var password: String
    
    init() {}

    init(id: Int? = nil, username: String, password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
