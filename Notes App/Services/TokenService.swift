//
//  TokenService.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import SwiftUI
import JWTDecode
import Resolver

class TokenService {
    
    @Injected private var client: NetworkingClient
    
    @AppStorage("jwtToken") var jwtToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
        
    func saveJWTToken(_ token: String) {
        
        jwtToken = token
    }
    
    func saveRefreshToken(_ token: String) {
        
        refreshToken = token
    }
    
    func isJwtTokenValid() -> Bool {
        
       return isTokenValid(jwtToken)
    }
    
    func isRefreshTokenValid() -> Bool {
        
        return isTokenValid(refreshToken)
    }
    
    func generateNewJwtToken() async throws -> HttpLoginSuccessResponse  {
        
        guard let url = URL(string: URLs.POST_refreshToken) else { throw APIErrors.invalidUrl }
        let body = ["refreshToken": refreshToken]
        let headers = ["Content-Type" : "application/json"]
        
        // TODO: Refresh the Token
        let response = try await client.makeRequest(type: HttpLoginSuccessResponse.self,
                           withMethod: .POST,
                           url: url,
                           body: body,
                           headers: headers)
        return response
    }
    
    func logout() {
        
        jwtToken = ""
        refreshToken = ""
    }
    
    private func isTokenValid(_ token: String) -> Bool {
        
        do {
            let jwt = try decode(jwt: token)
            return !jwt.expired
        } catch {
            return false
        }
    }
}
