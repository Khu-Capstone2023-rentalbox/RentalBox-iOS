//
//  User.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/19.
//

import Foundation

struct LoginResopnse: Codable {
    let message: String?
    let code: Int?
    let isSuccess: Bool?
    let clubName: String?
    let data: String?
    
    enum CodingKeys: String, CodingKey {
        case message, code, isSuccess, clubName
        case data = "token"
    }
}

struct User: Codable {
    let id: Int
    let name: String
    let club_id: Int?
    let crated_at: Date
    var updated_at: Date?
    
    
}
