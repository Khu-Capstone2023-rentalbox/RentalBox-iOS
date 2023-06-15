//
//  FixtureViewModel.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/17.
//

import Foundation
import Alamofire

struct Fixtures: Codable {
    var isSuccess: Bool
    var message: String
    var code: Int
    var data: [Book]
    
    enum codingKeys: String, CodingKey {
        case isSuccess, message, code
        case data = "fixtures"
    }
}

class FixtureViewModel: ObservableObject {
    @Published var fixtures: Fixture?
    @Published var nameSort = SortBy.nameASC
    @Published var ratingSort = SortBy.ratingASC
    @Published var fixture: Book?
    @Published var inputText: String = ""
    @Published var mypageData: MypageData?
    @Published var mypageRentFixture: MypageRentFixture?
    func alamofireNetworking(url: String) {
        //MARK: URL생성, guard let으로 옵셔널 검사
        guard let sessionUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }
        print("get MainLists", sessionUrl)
        //MARK: Request생성
        let token = UserDefaultsManager.shared.getTokens()
        
        AF.request(sessionUrl,
                   method: .get, // HTTP메서드 설정
                   parameters: nil, // 파라미터 설정
                   encoding: URLEncoding.default, // 인코딩 타입 설정
                   headers: ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token.accessToken]) // 헤더 설정
        .validate(statusCode: 200..<300) // 유효성 검사
        //MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .responseDecodable(of: Fixture.self) { response in
            switch response.result {
            case .success(let fixture):
                self.fixtures = fixture
            case .failure(let error):
                print(error)
            }
        }
    }
    func alamofireFixtureUpload(url: String, itemName: String, count: Int) {
        guard let sessionUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }
        //MARK: Request생성
        let token = UserDefaultsManager.shared.getTokens()
        let bodyData: Parameters = [
            "itemName": itemName,
            "count": count
        ]
        print("fixture upload", sessionUrl)
        AF.request(sessionUrl,
                   method: .post, // HTTP메서드 설정
                   parameters: bodyData, // 파라미터 설정
                   encoding: JSONEncoding.default, // 인코딩 타입 설정
                   headers: ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token.accessToken])
        // 헤더 설정
        .validate(statusCode: 200..<300) // 유효성 검사
        //MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .response { response in
            switch response.result {
            case .success :
                print("Post Success")
            case .failure(let error) :
                print(error.errorDescription)
            }
        }
    }
    
    func alamofireFixtureDetail<T: Decodable>(url: String, itemId: Int) async throws -> T{
//        guard let sessionUrl = URL(string: url.appending("/\(itemId)")) else {
//            print("Invalid URL")
////            return Book(name: "오류 발생")
//            return
//        }
        let sessionUrl = URL(string: url.appending("/\(itemId)"))
        print("get fixture detail", sessionUrl)
        //MARK: Request생성
        let token = UserDefaultsManager.shared.getTokens()
        
        return try await AF.request(sessionUrl!,
                   method: .get, // HTTP메서드 설정
                   parameters: nil, // 파라미터 설정
                   encoding: URLEncoding.default, // 인코딩 타입 설정
                   headers: ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token.accessToken]) // 헤더 설정
//        .validate(statusCode: 200..<300) // 유효성 검사
//        MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .serializingDecodable()
        .value
//        .responseDecodable(of: FixtureDetail.self) { response in
//            switch response.result {
//            case .success(let book):
//                print(">>>>>>>>", book)
//                self.fixture = book.data
//
//            case .failure(let error):
//                print(error)
//            }
//        }
        
//        return try await fixture ?? Book(name: "오류 발생")
    }
    
    func alamofireGetMypageList(url: String) {
        guard let sessionUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }
        //MARK: Request생성
        let token = UserDefaultsManager.shared.getTokens()
        
        print("get my page", sessionUrl)
        AF.request(sessionUrl,
                   method: .get, // HTTP메서드 설정
                   parameters: nil, // 파라미터 설정
                   encoding: URLEncoding.default, // 인코딩 타입 설정
                   headers: ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token.accessToken]) // 헤더 설정
        .validate(statusCode: 200..<300) // 유효성 검사
        //MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .responseDecodable(of: MypageFixture.self) { response in
            switch response.result {
            case .success(let mypage):
                print(">>>>>>>>", mypage)
                self.mypageData = mypage.data
                
            case .failure(let error):
                print(error)
            }
        }
        print("<<<<<<<<<<", mypageData)
    }
    
    func getMypageRentFixtureDetail(url: String, itemId: Int) {
        let sessionUrl = URL(string: url.appending("/my-item/\(itemId)"))
        //MARK: Request생성
        let token = UserDefaultsManager.shared.getTokens()
        
        print("get my page Rent Fixture Detail", sessionUrl)
        AF.request(sessionUrl!,
                   method: .get, // HTTP메서드 설정
                   parameters: nil, // 파라미터 설정
                   encoding: URLEncoding.default, // 인코딩 타입 설정
                   headers: ["Content-Type":"application/json", "Accept":"application/json", "x-access-token": token.accessToken]) // 헤더 설정
        .validate(statusCode: 200..<300) // 유효성 검사
        //MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
        .responseDecodable(of: MypageRentFixture.self) { response in
            switch response.result {
            case .success(let data):
                print(">>>>>>>>", data)
                self.mypageRentFixture = data
                
            case .failure(let error):
                print(error)
            }
        }
        print("<<<<<<<<<<", mypageRentFixture)
    }
    
    // For convinience. Sort type.
    enum SortBy: String {
        case nameASC = "Name △"
        case nameDESC = "Name ▽"
        case ratingASC = "Date △"
        case ratingDESC = "Date ▽"
    }
}
