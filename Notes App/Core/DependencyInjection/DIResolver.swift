//
//  DIResolver.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering {
    
    public static func registerAllServices() {
        
        register { BuildConfiguration.shared }
        
        register { URLSession(configuration: .default) }
        
        register { AuthController() }
        register { NotesController() }
        register { SettingsController() }
        
        register { AuthService() }
        register { TokenService() }
        register { NotesService() }
        register { UserService() }
        
        register { NetworkingClient() }
        register { AuthNetworkingClient() }
    }
}
