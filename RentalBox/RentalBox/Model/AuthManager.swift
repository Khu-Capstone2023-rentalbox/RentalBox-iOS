//
//  AuthManager.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/23.
//

import Foundation
import Alamofire

class AuthManager: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
//        guard let accessToken = UserManager
        completion(.success(urlRequest))
    }

    func retry(_ request: Request,
                      for session: Session,
                      dueTo error: Error,
                      completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
