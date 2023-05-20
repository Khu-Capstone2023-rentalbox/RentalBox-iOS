//
//  fixture.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/10.
//

import Foundation

struct Fixture: Codable {
    var isSuccess: Bool
    var message: String
    var code: Int
    var data: [Book]
    
    enum codingKeys: String, CodingKey {
        case isSuccess, message, code
        case data = "fixtures"
    }
}

struct Book: Codable {
    let id: Int
    let name: String
    let created_at: Date?
    let updated_at: Date?
    var count: Int?
    
}
