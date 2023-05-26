//
//  MainView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/04/27.
//

import SwiftUI
import UIKit
struct MainView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @State private var register = false
    @State private var rent = false
    
    @EnvironmentObject var networking: FixtureViewModel
    @EnvironmentObject var userVM: UserVM
   
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.4)
                .ignoresSafeArea()
            VStack {
                HeaderView(isMain: true)
                    .frame(height:screenHeight / 10)
                HStack {
                    Text("물품 리스트")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                    Spacer()
                }
                .padding()
                HStack {
                    SearchBarView()
                }
                .padding(.horizontal)
                MainListView(dummyList: networking.fixtures?.data ?? [Book(bookId: 0, name: "인가탐", created_at: Date.now, updated_at: Date.now)])
                    .padding()
                Spacer()
                HStack {
                    Button {
                        register = true
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth / 3, height: 50)
                            .foregroundColor(.white)
                            .overlay(
                                Text("등록하기")
                            )
                    }
                    .sheet(isPresented: $register) {
                        RegisterView()
                    }
                    Spacer()
                        .frame(width: screenWidth / 10)
                    Button {
                        rent = true
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: screenWidth / 3, height: 50)
                            .foregroundColor(.white)
                            .overlay(
                                Text("대여하기")
                            )
                    }
                    .sheet(isPresented: $rent) {
                        RentView()
                    }
                }
                .padding()
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
