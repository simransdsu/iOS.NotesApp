//
//  LoginViewModel.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import Combine
import Resolver

@MainActor
class LoginViewModel: ObservableObject {
    
    @Published var emailTextField: String = ""
    @Published var passwordTextField: String = ""
    @Published var isFormValid: Bool = false
    @Published var userSuccessfullySignedIn = false
    @Published var showLoginError = false
    @Published var loginErrorMessage: String = ""
    @Published var viewState: AuthViewState = .loggedOut
    
    private var cancellable = Set<AnyCancellable>()
    
    @Injected private var authController: AuthController
    
    init() {
        setupEmailTextFieldValidation()
    }
    
    public func login() async {
        print("\(self) \(#function)")
        viewState = .loading
        do {
            try await authController.login(email: emailTextField, password: passwordTextField)
            
            self.userSuccessfullySignedIn = true
            self.showLoginError = false
            self.emailTextField = ""
            self.passwordTextField = ""
            viewState = .loggedIn
        } catch let error {
            self.loginErrorMessage = handleError(error: error)
            self.userSuccessfullySignedIn = false
            self.showLoginError = true
            self.passwordTextField = ""
            viewState = .error(handleError(error: error))
        }
    }
    
    private func setupEmailTextFieldValidation() {
        $emailTextField
            .combineLatest($passwordTextField)
            .sink { [weak self] email, password in
                guard let self = self else { return }
                self.isFormValid = email.trim().lowercased().isValidEmail() && password.count >= 8
            }.store(in: &cancellable)
    }
}


extension LoginViewModel: ErrorHandler {}
