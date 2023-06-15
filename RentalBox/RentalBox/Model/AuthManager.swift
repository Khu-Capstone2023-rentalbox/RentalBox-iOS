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

////
////  AuthApiService.swift
////  RentalBox
////
////  Created by MBSoo on 2023/05/24.
////
//
//import Foundation
//import Alamofire
//import Combine
//
//// 인증 관련 api 호출
//enum AuthApiService {
//
//    // 회원가입
//    static func register(name: String, email: String, password: Int) -> AnyPublisher<AuthResponse, AFError>{
//        print("AuthApiService - register() called")
//
//        return ApiClient.shared.session
//            .request(AuthRouter.register(name: name, email: email, password: password))
//            .publishDecodable(type: AuthResponse.self)
//            .value()
//            .map{ receivedValue in
//                // 받은 토큰 정보 어딘가에 영구 저장
//                // userdefaults, keychain
//                UserDefaultsManager.shared.setTokens(accessToken: receivedValue.token)
//                UserDefaultsManager.shared.setConstants(clubName: receivedValue.clubName)
//                return receivedValue
//            }.eraseToAnyPublisher()
//    }
//
//    // 로그인
//    static func login(email: String, password: Int) -> AnyPublisher<AuthResponse, AFError>{
//        print("AuthApiService - register() called")
//
//        return ApiClient.shared.session
//            .request(AuthRouter.login(email: email, password: password))
//            .publishDecodable(type: AuthResponse.self)
//            .value()
//            .map{ receivedValue in
//                // 받은 토큰 정보 어딘가에 영구 저장
//                // userdefaults, keychain
//                UserDefaultsManager.shared.setTokens(accessToken: receivedValue.token)
//                UserDefaultsManager.shared.setConstants(clubName: receivedValue.clubName)
//                return receivedValue
//            }.eraseToAnyPublisher()
//    }
//
//}
//
