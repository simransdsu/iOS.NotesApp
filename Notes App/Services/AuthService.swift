//
//  AuthService.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import Foundation
import Resolver

class AuthService {
    
    @Injected private var client: NetworkingClient
    
    func signup(name: String, email: String, password: String) async throws {
        print("\(self) \(#function)", URLs.POST_signupURL)
        
        guard let url = URL(string: URLs.POST_signupURL) else { return }
        let body = [
            "email": email,
            "name": name,
            "password": password
        ]
        let headers = ["Content-Type" : "application/json"]
        
        _ = try await client.makeRequest(type: HttpMessageResponse.self,
                                                    withMethod: .POST,
                                                    url: url,
                                                    body: body,
                                                    headers: headers)
        
    }
    
    func login(email: String, password: String) async throws -> HttpLoginSuccessResponse {
        print("\(self) \(#function)", URLs.POST_loginURL)
        
        guard let url = URL(string: URLs.POST_loginURL) else {
            throw APIErrors.invalidUrl
        }
        
        let body = [
            "username": email,
            "password": password
        ]
        
        let response = try await client.makeRequest(type: HttpLoginSuccessResponse.self,
                                                    withMethod: .POST,
                                                    url: url,
                                                    body: body,
                                                    headers: ["Content-Type" : "application/json"])
        return response
    }
}
