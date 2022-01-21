//
//  SignupViewModel.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import Combine
import Foundation
import Resolver

@MainActor
class SignupViewModel: ObservableObject, ErrorHandler {
    
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var nameTextField: String = ""
    @Published var isFormValid: Bool = false
    @Published var userSuccessfullyCreatedAndSignIn = false
    @Published var showSignupError = false
    @Published var signupErrorMessage: String = ""
    @Published var viewState: AuthViewState = .loggedOut
    
    
    private var cancellable = Set<AnyCancellable>()
    
    @Injected private var authController: AuthController
    
    init() {
        setupEmailTextFieldValidation()
    }
    
    public func signup() async {
        print("\(self) \(#function)")
        viewState = .loading
        
        do {
            try await authController.signup(name: nameTextField, email: emailTextField, password: passwordTextField)
            try await authController.login(email: emailTextField, password: passwordTextField)
            
            self.userSuccessfullyCreatedAndSignIn = true
            self.showSignupError = false
            self.emailTextField = ""
            self.passwordTextField = ""
            self.nameTextField = ""
            viewState = .loggedIn
        } catch let error {
            self.signupErrorMessage = handleError(error: error)
            self.userSuccessfullyCreatedAndSignIn = false
            self.showSignupError = true
            self.passwordTextField = ""
            viewState = .error(handleError(error: error))
        }
    }
    
    
    private func setupEmailTextFieldValidation() {
        $emailTextField
            .combineLatest($passwordTextField, $nameTextField)
            .sink { [weak self] email, password, name in
                guard let self = self else { return }
                self.isFormValid =  name.trim().count >= 1 && email.trim().lowercased().isValidEmail() && password.count >= 8
            }.store(in: &cancellable)
    }
    
}
