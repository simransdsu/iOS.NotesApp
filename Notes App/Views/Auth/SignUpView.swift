//
//  SignUpView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2021-12-27.
//

import SwiftUI

struct SignUpView: View {
    
    @StateObject private var signupViewModel = SignupViewModel()
    @EnvironmentObject private var authSession: AuthSession
    
    var body: some View {
        
        ZStack {
            VStack {
                logoImage
                nameTextField
                emailTextField
                passwordTextField
                signupButton
                Spacer()
                loginFootNote
            }
            
            if signupViewModel.viewState == .loading {
                CCLoadingView(message: "Signing in...")
            }
            
        }
        .padding()
        .fullScreenCover(isPresented: $signupViewModel.userSuccessfullyCreatedAndSignIn, content: {
            HomeView()
        })
        .alert(isPresented: $signupViewModel.showSignupError) {
            Alert(title: Text(signupViewModel.signupErrorMessage))
        }
    }
    
    
    // MARK: - UI Views
    private var logoImage: some View {
        CCResizableSquareImage("clap-512", size: 150)
            .cornerRadius(15)
    }
    
    private var nameTextField: some View {
        CCRoundedTextField(titleKey: "Name (2 or more characters)",
                           text: $signupViewModel.nameTextField)
    }
    
    private var emailTextField: some View {
        CCRoundedTextField(titleKey: "Email (something@email.com)",
                           text: $signupViewModel.emailTextField)
            .keyboardType(.emailAddress)
    }
    
    private var passwordTextField: some View {
        CCRoundedSecureTextfield(titleKey: "Password (8 or more characters)",
                                 text: $signupViewModel.passwordTextField)
    }
    
    private var signupButton: some View {
        CCButton(action: { signup() }, text: "Sign Up").padding(.vertical, 20)
            .disabled(!signupViewModel.isFormValid)
            .opacity(signupViewModel.isFormValid ? 1 : 0.6)
    }
    
    private var loginFootNote: some View {
        CCFootnoteButton(action: disableLoginView,
                         plainText: "Already have an account?",
                         highlightText:"Login")
    }
}


// MARK: - Private Methods
private extension SignUpView {
    
    private func disableLoginView() {
        withAnimation {
            authSession.showLoginView = true
        }
    }
    
    private func signup() {
        Task {
            await signupViewModel.signup()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    
    static var previews: some View {
        SignUpView()
    }
}
