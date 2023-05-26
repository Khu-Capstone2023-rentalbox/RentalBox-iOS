//
//  LoginView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/04/27.
//

import SwiftUI
import UIKit


struct LoginView: View {
    @State var studentID: Int = 0
    @State var submitComplete = false
    @State var loginComplete = false
    let screenWidth = UIScreen.main.bounds.width
    let url = "http://www.rentalbox.store"
    @EnvironmentObject var userModel: UserVM
    @EnvironmentObject var networking: FixtureViewModel
    var body: some View {
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
                    HStack {
                        Text("학번:")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .padding()
                        TextField("학번을 입력해주세요.", value: $studentID, formatter: formatter)
                            .frame(width: screenWidth - 170, height: 55)
                            .onChange(of: studentID) { newValue in
                                userModel.studentID = String(studentID)
                            }
                    }
                    .background(in: RoundedRectangle(cornerRadius: 10))
                    Button {
                        userModel.login(email: userModel.studentID, password: userModel.clubID)
                        submitComplete = true
                    } label: {
                        Text("완료")
                    }
                    .frame(width: 50,height: 55)
//                    .disabled(userModel.studentID.count != 8)
                }.padding()
                Button {
                    print(userModel.clubID)
                    print(userModel.studentID)
                    networking.alamofireNetworking(url: url)
                    loginComplete = true
                } label: {
                    Text("click")
                }.disabled(!submitComplete)
                
                NavigationLink {
                    MainView()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .overlay (
                            Text("로그인")
                        )
                        .frame(width: screenWidth / 2, height: 50)
                }.disabled(!loginComplete)
                //TODO: 값 입력 안 했을 경우, 백엔드에서 값 불러와서 맞춰보는 거 처리해야함
                Spacer()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
