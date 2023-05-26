//
//  FixtureView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/21.
//

import SwiftUI

struct FixtureRentView: View {
    var fixture: Book = Book(bookId: 1, name: "인가탐", created_at: Date.now, updated_at: Date.now)
    var dummyList = ["박재윤": Date.now, "민병수": Date.now, "최용욱": Date.now]
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = .current
        
        return formatter
    }
    
    let screenWidth = UIScreen.main.bounds.width
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            VStack {
                HeaderView(isMain: false)
                Text("\(fixture.name)")
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                    .padding()
                Text("책")
                    .font(.system(size: 18, weight: .light, design: .rounded))
                    .padding()
                Text("대여일: ")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .frame(width: screenWidth - 40, alignment: .leading)
                Text("반납 예정일: ")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .frame(width: screenWidth - 40, alignment: .leading)
                    .padding(.top)
                Text("연체일: ")
                    .font(.system(size: 24, weight: .semibold, design: .rounded))
                    .frame(width: screenWidth - 40, alignment: .leading)
                    .padding(.top)
                NavigationLink(destination: CameraView()) {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .overlay(
                            Text("반납하기")
                        )
                }
                .frame(width: 100, height: 40)
                .padding()
                Spacer()
            }
        }
    }
}

struct FixtureView_Previews: PreviewProvider {
    static var previews: some View {
        FixtureRentView()
    }
}
