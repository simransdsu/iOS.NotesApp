//
//  AuthViewState.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation

enum AuthViewState: Equatable {
    
    case loading
    case loggedIn
    case loggedOut
    case error(String)
}

