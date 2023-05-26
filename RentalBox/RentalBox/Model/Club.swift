//
//  Club.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/10.
//

import Foundation

struct Club: Codable {
    let isSuccess: Bool
    let code: Int
    let message: String
    var data: ClubDetails
    
    enum CodingKeys: String, CodingKey {
        case isSuccess,  code, message, data
    }
}

struct ClubDetails: Codable {
    let id: Int
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "insertedOrganization"
        case count = "insertedMemberCount"
    }
}
