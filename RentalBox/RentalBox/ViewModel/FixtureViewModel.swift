//
//  FixtureViewModel.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/17.
//

import Foundation

class FixtureViewModel: ObservableObject {
    @Published var fixtures = [Fixture]()
    @Published var nameSort = SortBy.nameASC
    @Published var ratingSort = SortBy.ratingASC
    init() {
//        fixtures = fetchFixtureData(url: <#T##String#>, completionHandler: <#T##(Bool, Any) -> Void#>)()/
        
    }
    
    private func fetchFixtureData(url: String, completionHandler: @escaping(Bool, Any) -> Void) {
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
//            guard let output = try? JSONDecoder().decode(Fixture.self, from: data) else {
                
//            }
        }
        
    }
    
//    private func loadFixtureData() -> [Fixture]{
//        var dbData = [Fixture]()
//
//        do {
//            if let filePath  = Bundle.main.url(forResource: "DBdata", withExtension: "json") {
//
//                let jsonData = try Data(contentsOf: filePath)
//                let decodedData = try JSONDecoder().decode([Daily].self, from: jsonData)
//                dbData = decodedData
//            } else {
//                return [Daily]()
//            }
//        } catch let error {
//            print("[System] Error while fetching: \(error)")
//        }
//        return dbData
//    }
//    func sortList(by sortType: SortBy) {
//           switch sortType {
//           case .nameASC: // name ascending
//               fixtures.sort {
//                   $0.data.lowercased() < $1.name.lowercased()
//               }
//           case .nameDESC: // name descending
//               fixtures.sort {
//                   $0.name.lowercased() > $1.name.lowercased()
//               }
//           case .ratingASC:  // rating ascending
//               fixtures.sort {
//                   $0.money < $1.money
//               }
//           case .ratingDESC: // rating descending
//               fixtures.sort {
//                   $0.money > $1.money
//               }
//           }
//       }

       // For convinience. Sort type.
       enum SortBy: String {
           case nameASC = "Name △"
           case nameDESC = "Name ▽"
           case ratingASC = "Date △"
           case ratingDESC = "Date ▽"
       }
}
