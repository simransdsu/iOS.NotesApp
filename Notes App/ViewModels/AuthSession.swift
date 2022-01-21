//
//  AuthViewModel.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Combine
import Resolver

@MainActor
class AuthSession: ObservableObject {

    @Injected private var authController: AuthController
    @Injected private var tokenService: TokenService
    
    @Published var showLoginView: Bool = true
    @Published var viewState: AuthViewState = .loading
    
    private var isUserLoggedIn: Bool = false
    
    init() {
        
        Task {
            await checkIsUserLoggedIn()
        }
    }
    
    func checkIsUserLoggedIn() async -> Bool {
        
        do {
            viewState = .loading
            isUserLoggedIn = try await authController.isUserLoggedIn()
            updateViewState()
        } catch {
            viewState = .loggedOut
        }
        return isUserLoggedIn
    }
    
    func logout() {
        
        tokenService.logout()
        viewState = .loggedOut
    }
    
    func changeViewState() {
        
        viewState = .loggedOut
    }
    
    private func updateViewState() {
        
        if isUserLoggedIn {
            viewState = .loggedIn
        } else {
            viewState = .loggedOut
        }
    }
}
