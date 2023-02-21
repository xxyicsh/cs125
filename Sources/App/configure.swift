import Vapor
import Fluent
import FluentMySQLDriver

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    //ignore tls
    var tls = TLSConfiguration.makeClientConfiguration()
    tls.certificateVerification = .none
    //configure mysql
    app.databases.use(.mysql(
        hostname: "127.0.0.1",
        username: "root",
        password: "root",
        database: "cs125",
        tlsConfiguration: tls
    ), as: .mysql)
    
    // register routes
    try routes(app)
}
