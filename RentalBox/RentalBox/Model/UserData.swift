//
//  UserData.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/24.
//

import Foundation

//"user": {
//        "id": 3,
//        "name": "tester01",
//        "email": "tester01@email.com",
//        "avatar": "https://www.gravatar.com/avatar/b87c0cd09c8c06be1d50f18d2104c814.jpg?s=200&d=robohash"
//    }

// 서버에서 넘어온 사용자 데이터
struct UserData : Codable{
    var isSuccess: String
    var code: Int
    var message: String
    var clubName: String
    var token: String
}
