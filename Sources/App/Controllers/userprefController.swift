import Vapor
import Fluent

struct userprefController: RouteCollection{
    func boot(routes: RoutesBuilder) throws {
        let prefs = routes.grouped("preference")
        prefs.get(use: getUserpref)
        prefs.put(use: updateUserpref)
        prefs.post(use: createUserpref)
    }
    
    //create user preference
    func createUserpref(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let pref = try req.content.decode(userpref.self)
        return pref.create(on: req.db)
            .transform(to: .ok)
    }
    
    //get user preference
    func getUserpref(req: Request) throws -> EventLoopFuture<userpref> {
        return userpref.query(on: req.db).all().map { prefs -> userpref in
            return prefs[0]
        }
    }
    
    //update user preference
    func updateUserpref(req: Request) throws -> EventLoopFuture<HTTPStatus> {
        let pref = try req.content.decode(userpref.self)
        return userpref.find(pref.id!, on: req.db).flatMap{ newpref -> EventLoopFuture<HTTPStatus> in
            if nil == newpref{
                return userpref.find(pref.id!, on: req.db).transform(to: .noContent)
            }
            newpref!.id = pref.id
            newpref!.breakfast = pref.breakfast
            newpref!.lunch = pref.lunch
            newpref!.dinner = pref.dinner
            newpref!.snack = pref.snack
            newpref!.dislike = pref.dislike
            newpref!.allergies = pref.allergies
            return newpref!.save(on: req.db).transform(to: .ok)
        }
    }
}
