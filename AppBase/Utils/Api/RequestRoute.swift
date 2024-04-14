import Foundation

public protocol RequestRoute {
    var path: String { get }
}

// example
//enum Routes: RequestRoute {
//    case signIn
//    case sendFeedback(id: String)
//
//    public var path: String {
//        switch (self) {
//        case .signIn:
//            return "api/auth/signIn"
//        case let .sendFeedback(id):
//            return "api/feedback/" + id
//        }
//    }
//}
