//
//  SettingsController.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-20.
//

import Foundation
import Resolver

class SettingsController {
    
    @Injected var userService: UserService
    
    func getLoggedUserInfo() async throws -> UserInfo {
        return try await userService.getLoggedInUser()
    }
}
