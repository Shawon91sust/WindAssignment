//
//  ServiceManager.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import Foundation
import Alamofire
import Combine

class ServiceManager {
    public static let shared = ServiceManager()
    
    func callService<T: Decodable>(urlString: String, method: HTTPMethod, params: Params? = nil, authToken : String? = "", success: @escaping ((T) -> Void), fail: @escaping ((NetworkError) -> Void)) {
        
        if !Reachability.isConnectedToNetwork() {
            fail(.noInternet)
            return
        }
        
        let url = URL(string: urlString)
        guard let urlObj = url else {
            fail(.urlFailed)
            return
        }
        
        AF.request(urlObj, method: method, parameters: params)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case let .success(payload):
                    success(payload)

                case .failure(let error):
                    print(error.localizedDescription)
                    fail(.apiError(error))
                }
            }
            
    }
    
    
//    func callService<T: Decodable>(urlString: String, params: Params? = nil, method: HTTPMethod) -> AnyPublisher<DataResponse<T, NetworkError>, Never>  {
//
//
//        return AF.request(urlString,
//                          method: method, parameters: params)
//            .validate()
//            .publishDecodable(type: T.self)
//            .map { response in
//                response.mapError { error in
//                    let backendError = response.data.flatMap { try? JSONDecoder().decode(BackendError.self, from: $0)}
//                    return NetworkError(initialError: error, backendError: backendError)
//                }
//            }
//            .receive(on: DispatchQueue.main)
//            .eraseToAnyPublisher()
//
//    }
}
