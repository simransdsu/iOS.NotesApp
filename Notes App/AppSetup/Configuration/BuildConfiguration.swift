//
//  BuildConfiguration.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-07.
//

import Foundation

class BuildConfiguration {
    static let shared = BuildConfiguration()
    var environment: DevEnvironment
    
    init() {
        let currentConfiguration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as! String
        
        environment = DevEnvironment(rawValue: currentConfiguration)!
    }
}


class URLs {
    static var baseURL: String {
        switch BuildConfiguration.shared.environment {
            case .debugStaging, .releaseStaging: return "https://another-notes-api.herokuapp.com"
            case .debugDevelopment, .releaseDevelopment: return "https://dev-another-notes-app.herokuapp.com/"
            case .debugProduction, .releaseProduction: return "https://another-notes-api.herokuapp.com"
        }
    }
    static var POST_signupURL: String { return baseURL + "/signup" }
    static var POST_loginURL: String { return baseURL + "/login" }
    static var POST_me: String { return baseURL + "/me" }
    static var POST_refreshToken: String { return baseURL + "/refreshToken" }
}
