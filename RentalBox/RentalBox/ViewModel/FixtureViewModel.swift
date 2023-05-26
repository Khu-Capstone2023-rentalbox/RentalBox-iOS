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
    init() {
    }
    
    func fetchFixtureData(url: String, completionHandler: @escaping(Bool, Any) -> Void) {
        guard let sessionUrl = URL(string: url) else {
            print("Wrong Url")
            return
        }
        
        
        var requestURL = URLRequest(url: sessionUrl)
        requestURL.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: requestURL) { (data: Data?, resopnse: URLResponse?, error: Error?) in
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            guard let data = data, let resopnse = resopnse as? HTTPURLResponse, (200..<300) ~= resopnse.statusCode else {
                print(resopnse.debugDescription)
                return
            }
            guard let output = try? JSONDecoder().decode(Fixture.self, from: data) else {
                return
            }
            completionHandler(true, output.data)
        }.resume()
        
    }
    
    func alamofireNetworking(url: String) {
        //MARK: URL생성, guard let으로 옵셔널 검사
        guard let sessionUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }
        //MARK: Request생성
        let token = UserDefaultsManager.shared.getTokens()
        print(token.accessToken)
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
//    func alamofireFileUpload(url: String) {
//        guard let sessionUrl = URL(string: url) else {
//            print("Invalid URL")
//            return
//        }
//        AF.upload(multipartFormData: MultipartFormData, with: <#T##URLRequestConvertible#>)
//    }
    
    // For convinience. Sort type.
    enum SortBy: String {
        case nameASC = "Name △"
        case nameDESC = "Name ▽"
        case ratingASC = "Date △"
        case ratingDESC = "Date ▽"
    }
}
