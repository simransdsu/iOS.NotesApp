//
//  SettingsViewModel.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-20.
//

import Foundation
import Resolver

@MainActor
class SettingsViewModel: ObservableObject, ErrorHandler {
    
    @Injected var settingsController: SettingsController
    
    @Published var userInfo: UserInfo? = nil
    @Published var errorOccurred: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoading: Bool = false
    
    func getUserInfo() async {
        
        isLoading = true
        errorOccurred = false
        
        do {
            userInfo = try await settingsController.getLoggedUserInfo()
        } catch {
            errorOccurred = true
            errorMessage = handleError(error: error)
        }
        isLoading = false
    }
}
