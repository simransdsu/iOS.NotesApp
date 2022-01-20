//
//  HomeViewModel.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation
import Resolver


@MainActor
class HomeViewModel: ObservableObject, ErrorHandler {
    
    @Injected private var homeController: HomeController
    
    @Published var userName: String = ""
    
    func getUserInfo() async {
        do {
            let user = try await homeController.getLoggedUserInfo()
            userName = user.name
        } catch {
            userName = handleError(error: error)
        }
    }
}
