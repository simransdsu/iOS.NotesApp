//
//  SettingsView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: - Property wrappers
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var authSession: AuthSession
    
    @StateObject var settingsViewModel = SettingsViewModel()
    
    // MARK: - body
    var body: some View {
        ZStack {
            Form {
                userInfoView
                logoutButton
                
                if BuildConfiguration.shared.environment != .debugProduction {
                    debugMenu
                }
            }
            .refreshable {
                Task {
                    await settingsViewModel.getUserInfo()
                }
            }
            
            if settingsViewModel.isLoading && settingsViewModel.userInfo == nil{
                CCLoadingView(message: "")
            }
        }
        .alert(isPresented: $settingsViewModel.errorOccurred) {
            Alert(title: Text(settingsViewModel.errorMessage))
        }
        .navigationTitle("Settings")
        .task {
            await settingsViewModel.getUserInfo()
        }
    }
    
    // MARK: - UI Views
    private var userInfoView: some View {
        Section {
            Text(settingsViewModel.userInfo?.name ?? "")
            Text(settingsViewModel.userInfo?.username ?? "")
        }
    }
    
    private var logoutButton: some View {
        Button {
            authSession.logout()
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Logout")
                .foregroundColor(.red)
        }
    }
    
    private var debugMenu: some View {
        Group {
            NavigationLink("Settings") {
                SettingsView()
            }
            
            Button {
                authSession.changeViewState()
            } label: {
                Text("Change View State")
            }
            
            Section("Environment") {
                Text(BuildConfiguration.shared.environment.rawValue)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
