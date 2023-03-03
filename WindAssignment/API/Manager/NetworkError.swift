//
//  NetworkError.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import Foundation
import Alamofire

//struct NetworkError: Error {
//  let initialError: AFError
//  let backendError: BackendError?
//}
//
//
//struct BackendError: Codable, Error {
//    var status: String
//    var message: String
//}

enum NetworkError: Error {
    case decodingError(DecodingError)
    case apiError(Error)
    case urlFailed
    case invalidResponse
    case noInternet
    
    var localizedDescription: String {
        switch self {
        case .decodingError(let error):
            return error.localizedDescription
        case .apiError(let error):
            return error.localizedDescription
        case .urlFailed:
            return "Given URL was invalid"
        case .invalidResponse:
            return "Invalid response from the api"
        case .noInternet:
            return "Please check your internet connection."
        }
    }
}

