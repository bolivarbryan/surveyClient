// The Swift Programming Language
// https://docs.swift.org/swift-book
import Moya
import UIKit

public enum NimbleAPI {
    case register(email: String, name: String, password: String, passwordConfirmation: String)
    case loginWithEmail(email: String, password: String)
    case refreshToken(token: String)
    case logout(token: String)
    case forgotPassword(email: String)
    case surveyList(page: Int)
    case surveyDetails(surveyID: String)
    case userProfile
    
    private var clientID: String { "6GbE8dhoz519l2N_F99StqoOs6Tcmm1rXgda4q__rIw" }
    private var clientSecret: String { "_ayfIm7BeUAhx2W1OUqi20fwO3uNxfo1QstyKlFCgHw" }
}

extension NimbleAPI: TargetType {
    public var baseURL: URL { URL(string: "https://survey-api.nimblehq.co")! }
    
    public var path: String {
        switch self {
        case .register:
            return "/api/v1/registrations"
        case .loginWithEmail:
            return "/api/v1/oauth/token"
        case .refreshToken:
            return "/api/v1/oauth/token"
        case .logout:
            return "/api/v1/oauth/revoke"
        case .forgotPassword:
            return "/api/v1/passwords"
        case .surveyList:
            return "/api/v1/surveys"
        case .surveyDetails(surveyID: let surveyID):
            return "/api/v1/surveys/\(surveyID)"
        case .userProfile:
            return "/api/v1/me"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .register, .loginWithEmail, .refreshToken, .logout, .forgotPassword:
            return .post
        default:
            return .get
        }
    }

    public var task: Task {
        switch self {
        case .register(email: let email, name: let name, password: let password, passwordConfirmation: let passwordConfirmation):
            return .requestParameters(parameters: [
                "user": [
                    "email": email,
                    "name": name,
                    "password": password,
                    "password_confirmation": passwordConfirmation],
                "client_id": clientID,
                "client_secret": clientSecret], encoding: JSONEncoding.default)
        case .loginWithEmail(email: let email, password: let password):
            return  .requestParameters(parameters: [
                "email": email,
                "password": password,
                "client_id": clientID,
                "grant_type": "password",
                "client_secret": clientSecret], encoding: JSONEncoding.default)
        case .refreshToken(token: let token):
                return .requestParameters(parameters: [
                    "refresh_token": token,
                    "client_id": clientID,
                    "grant_type": "refresh_token",
                    "client_secret": clientSecret], encoding: JSONEncoding.default)
        case .logout(token: let token):
            return .requestParameters(parameters: [
                "token": token,
                "client_id": clientID,
                "client_secret": clientSecret], encoding: JSONEncoding.default)
        case .forgotPassword(email: let email):
            return .requestParameters(parameters: [
                "user": ["email": email],
                "client_id": clientID,
                "client_secret": clientSecret], encoding: JSONEncoding.default)
        case .surveyDetails:
            return .requestPlain
        case .surveyList(page: let page):
            //return .requestPlain
            return .requestParameters(parameters: ["page[number]": "\(page)", "page[size]": "2"], encoding: URLEncoding.default)
        case .userProfile:
            return .requestPlain
        }
    }
    
    public var validationType: ValidationType {
        switch self {
        default:
            return .none
        }
    }
    public var sampleData: Data {
        return "[{\"name\": \"name\"}]".data(using: String.Encoding.utf8)!
    }
    
    public var headers: [String: String]? {
        switch self {
        case .register, .loginWithEmail, .refreshToken, .logout, .forgotPassword:
            return [
                "Content-Type": "application/json"
            ]
        case .surveyList, .surveyDetails, .userProfile:
            return [
                "Authorization": "\(TokenType.fetch()) \(AccessToken.fetch())"
            ]
        }
    }

}

public func url(_ route: TargetType) -> String {
    route.baseURL.appendingPathComponent(route.path).absoluteString
}
