//
//  OAuthCredential.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/24.
//

import Foundation
import Alamofire

struct OAuthCredential : AuthenticationCredential {
    var requiresRefresh: Bool
    let accessToken: String
    
}
