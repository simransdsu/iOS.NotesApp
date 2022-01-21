//
//  UserInfor.swift
//  Notes App
//
//  Created by Simran Preet Singh Narang on 2022-01-08.
//

import Foundation

struct UserInfo: Codable {
    let userID: Int
    let username, email, name: String
    let isActive: Int
    let joinedDate: String
    let imageURL: String

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case username, email, name, isActive, joinedDate
        case imageURL = "imageUrl"
    }
}
