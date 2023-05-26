//
//  TokenData.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/24.
//

import Foundation
//"token": {
//        "token_type": "Bearer",
//        "expires_in": 30,
//        "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9",
//        "refresh_token": "def5020077bd8b8b4ea3a4fa3d85480afd2bdfafefe85bbf03d8598994bcd48f20120d1f3f5f61538c3a4fe22"
//    }

//{
//    "isSuccess": true,
//    "code": 200,
//    "message": "success",
//    "data": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyQ2x1YiI6MSwiaWF0IjoxNjgzNzE2MzQyLCJleHAiOjE2ODYzMDgzNDIsInN1YiI6InVzZXJJbmZvIn0.YjX2xnsp9qF5KsHc2k8955YqIyLN6ZG7dxYOl8SK6vo"
//}

// MARK: - TokenData
struct TokenData: Codable {
    let accessToken: String
}
