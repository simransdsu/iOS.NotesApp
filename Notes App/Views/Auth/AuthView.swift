//
//  LoginView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2021-12-27.
//

import SwiftUI
import Resolver

struct AuthView: View {

    @StateObject private var authSession: AuthSession = AuthSession()

    @State var showLoginView: Bool = true
    
    var body: some View {
        ZStack {
            switch($authSession.viewState.wrappedValue) {
            case .loading:
                CCSplashScreenView()
            case .loggedIn:
                HomeView()
                    .environmentObject(authSession)
            case .loggedOut:
                if showLoginView {
                    LoginView(showLoginView: $showLoginView)
                        .environmentObject(authSession)
                } else {
                    SignUpView(showLoginView: $showLoginView)
                        .environmentObject(authSession)
                }
            case .error(_):
                EmptyView()
            }
        }.navigationBarHidden(true)
    }
    
}

struct SignupLoginView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
