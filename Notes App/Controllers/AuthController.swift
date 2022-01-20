//
//  LoginController.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import Foundation
import Resolver

class AuthController {
    
    @Injected private var authService: AuthService
    @Injected private var tokenService: TokenService
    
    func signup(name: String, email: String, password: String) async throws {
        print("\(self) \(#function)")
        try await authService.signup(name: name, email: email, password: password)
    }
    
    func login(email: String, password: String) async throws {
        print("\(self) \(#function)")
        
        let loginResponse = try await authService.login(email: email, password: password)
        tokenService.saveJWTToken(loginResponse.jwtToken)
        tokenService.saveRefreshToken(loginResponse.refreshToken)
    }
    
    func isUserLoggedIn() async throws -> Bool {
        if tokenService.isJwtTokenValid() {
            return true
        }
        
        if tokenService.isRefreshTokenValid() {
            do {
                try await getNewJwtToken()
                return true
            } catch {
                return false
            }
        }
        
        return false
    }
    
    func isRefreshTokenValid() -> Bool {
        return tokenService.isRefreshTokenValid()
    }
    
    func getNewJwtToken() async throws {
        let tokens = try await tokenService.generateNewJwtToken()
        tokenService.saveJWTToken(tokens.jwtToken)
        tokenService.saveRefreshToken(tokens.refreshToken)
    }
}
