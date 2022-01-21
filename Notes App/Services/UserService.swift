//
//  UserService.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-20.
//

import Foundation
import Resolver

class UserService {
    
    @Injected private var authClient: AuthNetworkingClient
    
    func getLoggedInUser() async throws -> UserInfo {
        
        guard let url = URL(string: URLs.POST_me) else {
            throw APIErrors.invalidUrl
        }
        
        return try await authClient.makeAuthenticatedRequest(type: UserInfo.self,
                                                             withMethod: .POST,
                                                             url: url,
                                                             headers: ["Content-Type" : "application/json"])
    }
}
