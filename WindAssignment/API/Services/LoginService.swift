//
//  LoginService.swift
//  WindAssignment
//
//  Created by Shawon Rejaul on 3/3/23.
//

import Foundation
import Combine

class LoginService {
    
    
    
    func performLogin(params: Params ,success: @escaping ((LoginResponse) -> Void), fail: @escaping ((NetworkError) -> Void)) {
        
        let loginUrl = GetPath(.Login)
        print(loginUrl)
        ServiceManager.shared.callService(urlString: loginUrl, method: .post, params: params) { (response: LoginResponse) in
            success(response)
        } fail: { error in
            fail(error)
        }
    }
    
    
    
    func performLoginDemo(success: @escaping ((LoginResponse) -> Void), fail: @escaping ((NetworkError) -> Void)) {
        let jsonStr = """
        {
          "status": true,
          "messages": [
            "Request Seccess"
          ],
          "data": {
            "userInfo": {
              "Id": 365,
              "Email": "nadimh@wind.app",
              "UserName": "nadimh",
              "WalletAddress": "0x95d8efac952e42148a4faf091e5b2407a7834e77",
              "smartContactWallet": "0x4dda336dCFF6B88078909E9b156d36A91EA00087",
              "ProfileImage": "https://lh3.googleusercontent.com/a/AEdFTp4zOK4n_7WajLyS9qa8ppvAqMVvGeJMuGflMzwGfQ=s96-c"
            },
            "accountInfo": {
              "balance": 381.500956,
              "currency": "USDC"
            }
          }
        }
    """

        let data = jsonStr.data(using: .utf8)!
        
        if let response = try? JSONDecoder().decode(LoginResponse.self, from: data) {
            success(response)
        } else {
            fail(.invalidResponse)
        }
        
        
        
    }
}
