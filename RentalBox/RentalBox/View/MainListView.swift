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
    var count: Int?
    enum categories: String, CaseIterable {
        case book = "책"
        case boardGame = "보드게임"
        case stuff = "비품"
        case etc = "기타"
    }
}

struct MainListView: View {
    @State var dummyList: [Book] = [Book(bookId: 0, name: "인가탐", created_at: Date.now, updated_at: Date.now)]
    var isMypage = false
    var body: some View {
        VStack {
            List(dummyList, id:\.self) { row in
                HStack {
                    if isMypage {
                        NavigationLink(destination: FixtureRentView(fixture: row)){
                            Text(row.name)
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                            Text(String(row.bookId))
                                .font(.system(size: 10, weight: .light, design: .rounded))
                        }
                    } else {
                        NavigationLink(destination: FixtureDetailView(fixture: row)){
                            Text(row.name)
                                .font(.system(size: 15, weight: .bold, design: .rounded))
                            Text(String(row.bookId))
                                .font(.system(size: 10, weight: .light, design: .rounded))
                        }
                    }
                    Spacer()
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
