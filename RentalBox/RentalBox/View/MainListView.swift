//
//  MainListView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/20.
//

import SwiftUI

struct Dummy: Hashable {
    var name: String
    var category: categories
    
    enum categories: String, CaseIterable {
        case book = "책"
        case boardGame = "보드게임"
        case stuff = "비품"
        case etc = "기타"
    }
}

struct MainListView: View {
    @State var dummyList: [Dummy] = [Dummy(name: "인간의 가치 탐색", category: .book), Dummy.init(name: "물리학 및 실험", category: .book), Dummy.init(name: "아발론", category: .boardGame)]
    
    var body: some View {
        VStack{
            List(dummyList, id:\.self) { row in
                HStack {
                    Text(row.name)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                    Spacer()
                    Text(row.category.rawValue)
                        .font(.system(size: 10, weight: .light, design: .rounded))
                    
                }
            }
            .scrollContentBackground(.hidden)
        }
    }
}

struct MainListView_Previews: PreviewProvider {
    static var previews: some View {
        MainListView()
    }
}
