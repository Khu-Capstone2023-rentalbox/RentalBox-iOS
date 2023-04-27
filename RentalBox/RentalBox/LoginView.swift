//
//  LoginView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/04/27.
//

import SwiftUI
import UIKit


struct LoginView: View {
    @State var studentID: String?
    let screenWidth = UIScreen.main.bounds.width
    
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
                    Text("학번:")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .padding()
                    TextField("학번을 입력해주세요.", value: $studentID, formatter: formatter)
                }
                .background(in: RoundedRectangle(cornerRadius: 10))
                .padding()
                NavigationLink {
                    LoginView()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .overlay (
                            Text("로그인")
                        )
                        .frame(width: screenWidth / 2, height: 50)
                }
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
