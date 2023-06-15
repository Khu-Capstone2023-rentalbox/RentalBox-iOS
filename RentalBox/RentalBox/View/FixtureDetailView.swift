//
//  FixtureDetailView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/21.
//

import SwiftUI
import UIKit

var dateFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.dateFormat = "yyyy-MM-dd"
    formatter.locale = .current
    
    return formatter
}

struct FixtureDetailView: View {
    var fixture: Book
    var dummyList = ["박재윤": Date.now, "민병수": Date.now, "최용욱": Date.now]
    
    var rental: [Rental]?
    let url = "http://www.rentalbox.store/items"
    @ObservedObject var networking: FixtureViewModel
    
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    HeaderView(isMain: false)
                    Text("\(fixture.name)")
                        .font(.system(size: 30, weight: .medium, design: .rounded))
                        .padding()
                    Text("책")
                        .font(.system(size: 18, weight: .light, design: .rounded))
                    Text("개수: \(fixture.count ?? 0)")
                        .padding()
                    Text("대여자 명단")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .frame(width: screenWidth - 40, alignment: .leading)
                    Text("이름    반납예정일")
                        .font(.system(size: 24, weight: .semibold, design: .rounded))
                        .frame(width: screenWidth - 100, alignment: .leading)
                        .padding(.top)
                    Form {
                        ForEach(fixture.rentals ?? [Rental(owner_name: "", return_time: "")], id:\.self) { row in
                            Text("\(row.owner_name)    \(row.return_time)")
                                .frame(width: screenWidth - 100, alignment: .leading)
                        }
                        .padding()
                    }
                    Spacer()
                    NavigationLink(destination: CameraView(isReturn: false)) {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .overlay(
                                Text("대여하기")
                            )
                    }
                    .frame(width: 100, height: 40)
                    .padding()
                }
            }
        }.background(Color.gray.opacity(0.4).ignoresSafeArea())
    }
}

//struct FixtureDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        FixtureDetailView(fixture: Book(name: "인가탐"))
//    }
//}
