//
//  UserVM.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/24.
//

import Foundation
import Alamofire
import Combine

class UserVM: ObservableObject {
    
    //MARK: properties
    var subscription = Set<AnyCancellable>()
    
    @Published var loggedInUser: AuthResponse? = nil
    
    @Published var users : [UserData] = []
    
    @Published var studentID: String = "0" {
        didSet {
            print(studentID)
        }
    }
    
    @Published var clubID: Int = 0 {
        didSet {
            print(clubID)
        }
    }
    
    // 회원가입 완료 이벤트
    var registrationSuccess = PassthroughSubject<(), Never>()
    
    // 로그인 완료 이벤트
    var loginSuccess = PassthroughSubject<(), Never>()
    
    /// 회원가입 하기
    func register(name: String, email: String, password: Int){
        print("UserVM: register() called")
        AuthApiService.register(name: name, email: email, password: password)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("UserVM completion: \(completion)")
            } receiveValue: { (receivedUser: AuthResponse) in
                self.loggedInUser = receivedUser
                self.registrationSuccess.send()
            }.store(in: &subscription)
    }
    
    /// 로그인 하기
    func login(email: String, password: Int){
        print("UserVM: login() called")
        AuthApiService.login(email: email, password: password)
            .sink { (completion: Subscribers.Completion<AFError>) in
                print("UserVM completion: \(completion)")
            } receiveValue: { (receivedUser: AuthResponse) in
                self.loggedInUser = receivedUser
                self.loginSuccess.send()
                print(receivedUser.isSuccess)
            }.store(in: &subscription)
    }
    
    // 현재 사용자 정보 가져오기
//    func fetchCurrentUserInfo(){
//        print("UserVM - fetchCurrentUserInfo() called")
//        UserApiService.fetchCurrentUserInfo()
//            .sink { (completion: Subscribers.Completion<AFError>) in
//                print("UserVM fetchCurrentUserInfo completion: \(completion)")
//            } receiveValue: { (receivedUser: AuthResponse) in
//                print("UserVM fetchCurrentUserInfo receivedUser: \(receivedUser)")
//                self.loggedInUser = receivedUser
//            }.store(in: &subscription)
//    }
    
    // 모든 사용자 가져오기
//    func fetchUsers(){
//        print("UserVM - fetchUsers() called")
//        UserApiService.fetchUsers()
//            .sink { (completion: Subscribers.Completion<AFError>) in
//                print("UserVM fetchUsers completion: \(completion)")
//            } receiveValue: { (fetchedUsers: [UserData]) in
//                print("UserVM fetchUsers fetchedUsers.count: \(fetchedUsers.count)")
//                self.users = fetchedUsers
//            }.store(in: &subscription)
//    }
    
}
