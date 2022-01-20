//
//  HomeController.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation
import Resolver

class HomeController {
    
    @Injected var homeService: UserService
    
    func getLoggedUserInfo() async throws -> HttpLoggedInUserResponse {
        return try await homeService.getLoggedInUser()
    }
}
