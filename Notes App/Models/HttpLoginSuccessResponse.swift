//
//  HttpLoginSuccessResponse.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation

struct HttpLoginSuccessResponse: Codable {
    let jwtToken: String
    let refreshToken: String
}
