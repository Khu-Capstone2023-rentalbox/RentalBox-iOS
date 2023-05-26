//
//  ContentView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/04/11.
//

import SwiftUI
import CoreData

struct ContentView: View {
    let screenWidth = UIScreen.main.bounds.width
    
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var networking: FixtureViewModel
    @State var enteringCode: Int?
    var body: some View {
        NavigationView {
            ZStack {
                Color.gray.opacity(0.4)
                    .ignoresSafeArea()
                VStack {
                    Text("RentalBox")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    Text("동아리 비품 관리를 손 쉽게!")
                        .font(.system(size: 10, weight: .light))
                    Spacer()
                    HStack {
                        Text("참여코드:")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .padding()
                        TextField("참여 코드를 입력해주세요.", value: $userModel.clubID, formatter: formatter)
                    }
                    .background(in: RoundedRectangle(cornerRadius: 10))
                    .padding()
                    NavigationLink {
                        LoginView()
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .overlay (
                                Text("입력완료")
                            )
                            .frame(width: screenWidth / 2, height: 50)
                    }
                    Text("또는")
                        .font(.system(size: 13, weight: .light, design: .default))
                    NavigationLink {
                        ClubRegisterView()
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .overlay (
                                Text("동아리 생성하기")
                            )
                            .frame(width: screenWidth / 2, height: 50)
                    }
                    //TODO: 값 입력 안 했을 경우, 백엔드에서 값 불러와서 맞춰보는 거 처리해야함

                    Text("동아리를 직접 생성해보세요.")
                        .font(.system(size: 13, weight: .light, design: .default))
                    Spacer()
                }
            }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserVM())
    }
}
