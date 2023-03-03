//
//  LoginResponse.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    let status: Bool
    let messages: [String]?
    let data: UserData?
}

// MARK: - DataClass
struct UserData: Codable {
    let userInfo: UserInfo
    let accountInfo: AccountInfo
}

// MARK: - AccountInfo
struct AccountInfo: Codable {
    let balance: Double
    let currency: String
}

// MARK: - UserInfo
struct UserInfo: Codable {
    let id: Int
    let email, userName, walletAddress, smartContactWallet: String
    let profileImage: String

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case email = "Email"
        case userName = "UserName"
        case walletAddress = "WalletAddress"
        case smartContactWallet
        case profileImage = "ProfileImage"
    }
}
