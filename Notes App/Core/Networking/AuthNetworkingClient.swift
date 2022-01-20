//
//  AuthNetworkingClient.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation
import Resolver
import SwiftUI
import JWTDecode

class AuthNetworkingClient {
    
    @Injected private var networkingClient: NetworkingClient
    
    @AppStorage("jwtToken") var jwtToken: String = ""
    @AppStorage("refreshToken") var refreshToken: String = ""
    
    public func makeAuthenticatedRequest<ResponseType: Decodable>(
        type: ResponseType.Type,
        withMethod method: APIHttpMethod,
        url: URL,
        body: [String : String]? = nil,
        queryParameters: [String : String]? = nil,
        headers: [String : String]? = nil) async throws -> ResponseType {
            
            var mutableHeaders = headers
            mutableHeaders?["Authorization"] = "Bearer \(jwtToken)"
            
            if isJwtTokenValid() {
                return try await networkingClient.makeRequest(type: type,
                                                       withMethod: method,
                                                       url: url,
                                                       body: body,
                                                       queryParameters: queryParameters,
                                                       headers: mutableHeaders)
            } else {
                if isRefreshTokenValid() {
                    let jwtTokenResponse = try await generateNewJwtToken()
                    jwtToken = jwtTokenResponse.jwtToken
                    refreshToken = jwtTokenResponse.refreshToken
                    
                    return try await networkingClient.makeRequest(type: type,
                                                           withMethod: method,
                                                           url: url,
                                                           body: body,
                                                           queryParameters: queryParameters,
                                                           headers: headers)
                } else {
                    throw APIErrors.unauthorized
                }
            }
            
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
        let response = try await networkingClient.makeRequest(type: HttpLoginSuccessResponse.self,
                           withMethod: .POST,
                           url: url,
                           body: body,
                           headers: headers)
        return response
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
