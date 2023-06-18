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
    @State var rental: [Rental]?
    @State var fixtureDetail = FixtureDetail(isSuccess: false, message: "", code: 1)
    @State var book: Book = Book(name: "인가탐")
    @State var moveToList = false
    @Binding var inputText: String
    
    @ObservedObject var networking: FixtureViewModel
    var isMypage = false
    let url = "http://www.rentalbox.store"
    var body: some View {
        VStack {
            List(dummyList.filter({ book in
                filterSearchText(book)
            }), id:\.self) { row in
                HStack {
                    Text(row.name)
                        .font(.system(size: 15, weight: .bold, design: .rounded))
                    Spacer()
                    Image(systemName: "arrow.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10)
                        .foregroundColor(.green.opacity(0.8))
                }
                .contentShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    book = row
                    Task {
                        do {
                            self.fixtureDetail = try await networking.alamofireFixtureDetail(url: url.appending("/items"), itemId: row.bookId ?? 23)
                            
                            book = fixtureDetail.data ?? Book(name: "")
                            moveToList = true
                            print("no error")
                        } catch {
                            print(error)
                            moveToList = true
                            print("error")
                        }
                    }
                }
            }.scrollContentBackground(.hidden)
                .refreshable {
                    networking.alamofireNetworking(url: url)
                    dummyList = networking.fixtures?.data ?? []
                }
            
            NavigationLink(destination: FixtureDetailView(fixture: book, networking: networking), isActive: $moveToList) {
                Text("")
            }
        }
    }
        private func filterSearchText(_ book: Book) -> Bool {
            if inputText == "" || book.name.localizedCaseInsensitiveContains(inputText) {
                return true
            } else {
                return false
            }
        }
    }
    
    //struct MainListView_Previews: PreviewProvider {
    //    static var previews: some View {
    //        MainListView().environmentObject(FixtureViewModel())
    //    }
    //}
