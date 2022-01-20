//
//  SettingsView.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode)
    var presentationMode
    
    @EnvironmentObject var authSession: AuthSession
    
    var body: some View {
        Form {
            Button {
                authSession.logout()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Logout")
                    .foregroundColor(.red)
            }
            
            //---------------------------------------------------------//
            if BuildConfiguration.shared.environment != .debugProduction {
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
        }.navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
