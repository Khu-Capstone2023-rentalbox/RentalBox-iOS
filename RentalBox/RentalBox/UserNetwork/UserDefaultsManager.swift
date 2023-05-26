//
//  UserDefaultsManager.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/24.
//

import Foundation

class UserDefaultsManager {
    enum Key: String, CaseIterable{
        case accessToken
    }
    enum Constants: String, CaseIterable {
        case clubName
    }
    
    static let shared: UserDefaultsManager = {
        return UserDefaultsManager()
    }()
    
    // 저장된 모든 데이터 지우기
    func clearAll(){
        print("UserDefaultsManager - clearAll() called")
        Key.allCases.forEach{ UserDefaults.standard.removeObject(forKey: $0.rawValue) }
    }
    
    // 토큰들 저장
    func setTokens(accessToken: String){
        print("UserDefaultsManager - setTokens() called")
        UserDefaults.standard.set(accessToken, forKey: Key.accessToken.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func setConstants(clubName: String) {
        print("UserDefaultsManager - setConstants() called")
        UserDefaults.standard.set(clubName, forKey: Constants.clubName.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    // 토큰들 가져오기
    func getTokens()->TokenData{
        let accessToken = UserDefaults.standard.string(forKey: Key.accessToken.rawValue) ?? ""
        return TokenData(accessToken: accessToken)
    }
    func getClubName()->String {
        let clubName = UserDefaults.standard.string(forKey: Constants.clubName.rawValue) ?? ""
        return clubName
    }
}
