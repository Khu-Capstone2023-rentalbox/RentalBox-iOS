//
//  Club.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/10.
//

import Foundation

struct Club: Codable {
    let id: Int
    let name: String
    let created_at: Date
    var updated_at: Date
    var members: Int
}
