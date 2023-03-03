//
//  Constants.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 2/3/23.
//


import Foundation
import UIKit

public typealias AnyParameters = [String: Any]
typealias Params = [String: String]
typealias Headers = [String: String]

let keyWindow = UIApplication
                    .shared
                    .connectedScenes
                    .compactMap { $0 as? UIWindowScene }
                    .flatMap { $0.windows }
                    .first { $0.isKeyWindow }

let BaseUrl = "https://wind-assessment-api.vercel.app/api/v1"

enum Endpoint: String {
    case Login = "/login"
}

func GetPath(_ endPoint : Endpoint) -> String {
    return BaseUrl + endPoint.rawValue
}



enum BoardName: String {
    case Main
}

class Storyboards {
    static let sharedInstance = Storyboards()
    private init() { }
    
    func retrieveStoryBoard(_ boardName : BoardName) -> UIStoryboard {
        let storyBoard = UIStoryboard(name: boardName.rawValue, bundle: nil)
        return storyBoard
    }
}
