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
    let url = "http://www.rentalbox.store"
    
    @State private var register = false
    @State private var rent = false
    @State var inputText = ""
    @State var fixtures = Fixtures(isSuccess: false, message: "", code: 0, data: [])
    @ObservedObject var networking: FixtureViewModel
    @EnvironmentObject var userVM: UserVM
   
    var body: some View {
        ZStack {
            Color.gray
                .opacity(0.4)
                .ignoresSafeArea()
            VStack {
                HeaderView(isMain: true)
                    .frame(height:screenHeight / 10)
                    .environmentObject(networking)
                HStack {
                    Text("물품 리스트")
                        .font(.system(size: 25, weight: .bold, design: .rounded))
                    Spacer()
                }
                .padding()
                HStack {
                    SearchBarView(inputText: $inputText)
                        .environmentObject(networking)
                }
                .padding(.horizontal)
                MainListView(dummyList: networking.fixtures?.data ?? [Book(bookId: 0, name: "인가탐", created_at: Date.now, updated_at: Date.now)], inputText: $inputText, networking: networking)
                    .background(.clear)
                    .padding()
                    .refreshable {
                        await networking.alamofireNetworking(url: url)
                    }
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
                        FixtureRegisterView().environmentObject(networking)
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
        }.navigationBarHidden(true)
    }
}

//struct MainView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainView()
//    }
//}
