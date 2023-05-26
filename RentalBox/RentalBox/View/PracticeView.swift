//
//  PracticeView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/23.
//

import SwiftUI
import Alamofire

struct PracticeView: View {
    let gradient: LinearGradient = {
            let colors: [Color] = [.orange, .pink, .purple, .red, .yellow, .cyan]
                return LinearGradient(gradient: Gradient(colors: [colors.randomElement()!, colors.randomElement()!]), startPoint: .center, endPoint: .topTrailing)
            }()
        
        var body: some View {
            NavigationView {
                VStack {
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .padding()
                        .cornerRadius(10)
                    Spacer()
                    Divider()
                    Text("Click Here👇")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                        .frame(width: 300, alignment: .leading)
                        
                    VStack {
                        Button {
                            print("Alamofire Button Clicked")
                        } label: {
                            NavigationLink("Alamofire"){
                                AlamofireView()
                            }
                            .frame(width: 300)
                            .padding()
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                            
                        }
                        Button {
                            print("URLSession Button Clicked")
                        } label: {
                            NavigationLink("URLSession"){
                                SessionView()
                            }
                            .frame(width: 300)
                            .padding()
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                    }
                }
                .background(gradient)
            }
        }
}

struct UserDatas: Codable {
    var results: [RandomUser]
}

struct RandomUser: Codable, Identifiable {
    let id = UUID()
    let name: Name
    let email: String
    
    struct Name: Codable {
        var title: String
        var first: String
        var last: String
        
        var full: String {
            return "\(self.title.capitalized).\(self.last.capitalized) \(self.first.capitalized)"
        }
    }
    
    static func getDummy() -> Self {
        return RandomUser(name: Name.init(title: "MR", first: "Minhyun", last: "Cho"), email: "simh3077@gmail.com")
    }
}

class networkingClass: ObservableObject {
    
    @Published var randomUser = [RandomUser]()
    
    func urlSessionNetworking(url: String) {
        //MARK: URL생성, guard let으로 옵셔널 검사
        guard let sessionUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        //MARK: Default Session을 생성하거나, Shared Session을 생성 | 둘 다 상관X
        //let session = URLSession(configuration: .default)
        let session = URLSession.shared
        
        //MARK: Request 생성, URL은 위에서 생성한 URL을 파라미터로 넘겨줌, 생성한 requestURL의 HTTP메서드 설정
        var requestURL = URLRequest(url: sessionUrl)
        requestURL.httpMethod = "GET"
        
        //MARK: 헤더 설정, requestURL의 헤더에 넣어 헤더 사용
        let header: HTTPHeaders = ["Content-Type":"application/json", "Accept":"application/json"]
        requestURL.headers = header
        
        //MARK: Task 인스턴스 생성, Data Task 사용
        let dataTask = session.dataTask(with: requestURL) { (data, response, error) in
            // 에러검사
            guard error == nil else {
                print(error!)
                return
            }
            
            // data 확인 response의 유효성 검사
            guard let data = data, let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                return
            }
            
            // 데이터를 JSONDecoder()를 통해 UserDatas form으로 data를 디코딩하여 decodedData에 저장
            guard let decodedData = try? JSONDecoder().decode(UserDatas.self, from: data) else {
                print("Error: JSON parsing failed")
                return
            }
            // 디코드한 data값을 해당 클래스의 randomUser에 저장
            self.randomUser = decodedData.results
        }
        // resume()을 불러주어야 한다. Task는 기본적으로 suspended상태로 시작한다. 따라서 이를 호출해서 data task를 시작한다.
        // Task를 실행할 경우 강한 참조를 걸어 Task가 끝나거나 실패할 때까지 유지해준다. 네트워킹이 중간에 끊기지 않도록.
        dataTask.resume()
    }

    func alamofireNetworking(url: String) {
        //MARK: URL생성, guard let으로 옵셔널 검사
        guard let sessionUrl = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        //MARK: Request생성
        AF.request(sessionUrl,
                   method: .get, // HTTP메서드 설정
                   parameters: nil, // 파라미터 설정
                   encoding: URLEncoding.default, // 인코딩 타입 설정
                   headers: ["Content-Type":"application/json", "Accept":"application/json"]) // 헤더 설정
            .validate(statusCode: 200..<300) // 유효성 검사
            //MARK: responseDecodable을 통해 UserDatas form으로 디코딩, response의 성공 여부에 따라 작업 분기
            .responseDecodable (of: UserDatas.self) { response in
                switch response.result {
                case .success(let value):
                    self.randomUser = value.results
                case .failure(let error):
                    print(error)
                }
            }
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
    }
}
