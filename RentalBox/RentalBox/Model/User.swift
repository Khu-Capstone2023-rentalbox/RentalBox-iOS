//
//  User.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/19.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let club_id: Int?
    let crated_at: Date
    var updated_at: Date?
    
    
}
