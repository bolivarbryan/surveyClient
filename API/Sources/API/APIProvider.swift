import Foundation
import Moya

public struct APIProvider {
    
    private static func storeAccessToken(token: String) { }
    
    public static func request(service: NimbleAPI, completion: @escaping (Data) -> Void) {
        let provider = MoyaProvider<NimbleAPI>()
        provider.request(service) { result in
            switch result {
            case let .success(moyaResponse):
                let data = moyaResponse.data
                completion(data)
                let statusCode = moyaResponse.statusCode
                print("🟢 --> \(service.path): ", statusCode)
            case let .failure(error):
                print("🔴 --> ", error.localizedDescription)
            }
        }
    }
}
