//
//  ErrorHandler.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation

protocol ErrorHandler { }

extension ErrorHandler {
    func handleError(error: Error) -> String {
        
        if let error = error as? APIErrors {
            switch(error) {
                
            case .invalidResponse,
                    .invalidRequestWithIncorrectUrlFormat,
                    .invalidUrl:
                return "Something went wrong, please try again."
            case .badRequest(let message):
                return message
            case .unauthorized:
                return "Your session expired. Login again."
            }
        }
        return "Something went wrong, please try again."
    }
}
