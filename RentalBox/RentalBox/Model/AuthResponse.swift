//
//  AuthResponse.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/24.
//

import Foundation

struct AuthResponse : Codable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var clubName: String
    var token: String
}
