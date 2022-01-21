//
//  UserService.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation
import Resolver

class NotesService {
    
    @Injected private var authClient: AuthNetworkingClient
    
    func getUserNotes() async throws -> [Note] {
        guard let url = URL(string: URLs.GET_notes) else {
            throw APIErrors.invalidUrl
        }
        
        return try await authClient.makeAuthenticatedRequest(type: [Note].self,
                                                             withMethod: .GET,
                                                             url: url,
                                                             headers: ["Content-Type" : "application/json"])
    }
    
    func saveNote(_ noteText: String) async throws {
        guard let url = URL(string: URLs.POST_notes) else {
            throw APIErrors.invalidUrl
        }
        
        let body = [
            "noteText": noteText
        ]
        
        _ = try await authClient.makeAuthenticatedRequest(type: HttpMessageResponse.self,
                                                      withMethod: .POST,
                                                      url: url,
                                                      body: body,
                                                      headers: ["Content-Type" : "application/json"])
    }
    
    func deleteNote(_ id: Int) async throws {
        guard let url = URL(string: URLs.DELETE_notes(id: id)) else {
            throw APIErrors.invalidUrl
        }
        
        _ = try await authClient.makeAuthenticatedRequest(type: HttpMessageResponse.self,
                                                      withMethod: .DELETE,
                                                      url: url,
                                                      headers: ["Content-Type" : "application/json"])
    }
}
