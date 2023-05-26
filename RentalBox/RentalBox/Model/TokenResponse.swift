//
//  TokenResponse.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/24.
//

import Foundation
// MARK: - TokenResponse
struct TokenResponse: Codable {
    let message: String
    let token: TokenData
}
