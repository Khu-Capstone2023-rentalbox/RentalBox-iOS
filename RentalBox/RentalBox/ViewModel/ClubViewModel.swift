//
//  ClubViewModel.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/22.
//

import Foundation
import Alamofire

//struct Clubs: Codable {
//    var results = [Club]
//}

class ClubViewModel: ObservableObject {
    @Published var club: Club?
    
    func fetchClub() {
        guard let url = URL(string: "http://rentalbox.store/users/organization") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let error = error else {
                return
            }
        }
    }
    func registerClub() {
        guard let url = URL(string: "http://rentalbox.store/users/organization") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let error = error else {
                return
            }
        }
    }
    func uploadFile(fileURL: URL?, clubName: String) {
        guard let fileURL = fileURL else { return }
        let url = URL(string: "http://www.rentalbox.store/users/organization")
        fileURL.startAccessingSecurityScopedResource()
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(fileURL, withName: "excel")
            MultipartFormData.append("\(clubName)".data(using: .utf8)!, withName: "name")
        }, to: url!, method: .post)
        .responseDecodable(of:Club.self) { response in
            
            switch response.result {
            case .success(let result):
                self.club = result
                print(self.club?.data.id)
            case .failure(let error):
                print("File upload failed: \(error.localizedDescription)")
                
            }
        }
    }
    
    func requestPOSTWithMultipartform(url: String,
                                          parameters: [String : String],
                                          data: Data,
                                          filename: String,
                                          mimeType: String,
                                          completionHandler: @escaping (Bool, Any) -> Void) {
            guard let url = URL(string: url) else {
                print("Error: cannot create URL")
                return
            }

            // ✅ boundary 설정
            let boundary = "Boundary-\(UUID().uuidString)"

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            // request.httpBody = uploadData

            // ✅ data
            var uploadData = Data()
            let imgDataKey = "img"
            let boundaryPrefix = "--\(boundary)\r\n"

            for (key, value) in parameters {
                uploadData.append(boundaryPrefix.data(using: .utf8)!)
                uploadData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                uploadData.append("\(value)\r\n".data(using: .utf8)!)
            }

            uploadData.append(boundaryPrefix.data(using: .utf8)!)
            uploadData.append("Content-Disposition: form-data; name=\"\(imgDataKey)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
            uploadData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
            uploadData.append(data)
            uploadData.append("\r\n".data(using: .utf8)!)
            uploadData.append("--\(boundary)--".data(using: .utf8)!)

            let defaultSession = URLSession(configuration: .default)
            // ✅ uploadTask(with:from:) 메서드 사용해서 reqeust body 에 data 추가.
            defaultSession.uploadTask(with: request, from: uploadData) { (data: Data?, response: URLResponse?, error: Error?) in
                // ...
            }.resume()
        }
}
