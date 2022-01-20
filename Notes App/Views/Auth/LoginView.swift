//
//  LoginView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2021-12-27.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject private var loginViewModel = LoginViewModel()
    @EnvironmentObject private var authSession: AuthSession
    
    var body: some View {
        
        ZStack {
            VStack {
                logoImage
                emailTextField
                passwordTextField
                loginButton
                Spacer()
                signupFootNote
            }
            
            if loginViewModel.viewState == .loading {
                CCLoadingView(message: "Logging in...")
            }
        }
        .padding()
        .fullScreenCover(isPresented: $loginViewModel.userSuccessfullySignedIn, content: {
            MainHomeView()
        })
        .alert(isPresented: $loginViewModel.showLoginError) {
            Alert(title: Text(loginViewModel.loginErrorMessage))
        }
    }
    
    // MARK: - UI Views
    var logoImage: some View {
        CCResizableSquareImage("clap-512", size: 150)
            .cornerRadius(20)
    }
    
    var emailTextField: some View {
        CCRoundedTextField(titleKey: "Email (something@email.com)",
                           text: $loginViewModel.emailTextField)
            .keyboardType(.emailAddress)
    }
    
    var passwordTextField: some View {
        CCRoundedSecureTextfield(titleKey: "Password (8 or more characters)",
                                 text: $loginViewModel.passwordTextField)
    }
    
    var loginButton: some View {
        CCButton(action: login,
                 text: "Login")
            .padding(.vertical, 20)
            .disabled(!loginViewModel.isFormValid)
            .opacity(loginViewModel.isFormValid ? 1 : 0.6)
    }
    
    var signupFootNote: some View {
        CCFootnoteButton(action: enableLoginView,
                         plainText: "New to Twitter?",
                         highlightText:"Sign up")
    }
    
}


// MARK: - Private Methods
extension LoginView {
    
    private func enableLoginView() {
        withAnimation {
            authSession.showLoginView = false
        }
    }
    
    private func login() {
        Task {
            await loginViewModel.login()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
