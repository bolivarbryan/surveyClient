// The Swift Programming Language
// https://docs.swift.org/swift-book
import Moya

public enum NimbleAPI {
    case register(email: String, name: String, password: String, passwordConfirmation: String)
    case loginWithEmail(email: String, password: String)
    case refreshToken(token: String)
    case logout
    case forgotPassword(email: String)
    case surveyList(page: Int)
    case surveyDetails(surveyID: String)
    case userProfile
}

public struct API {
    public init() {
        
    }
    
    public func printTest() {
        print("API")
    }
}
