//
//  MyPageView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/10.
//

import SwiftUI

struct MyPageView: View {
    @State private var userName = "박재윤"
    @State private var logout = false
    
    
    var body: some View {
        NavigationView{
        ZStack {
            Color.gray
                .opacity(0.4)
                .ignoresSafeArea()
            VStack {
                HeaderView(isMain: false)
                HStack {
                    Text("\(userName)님의 대여리스트")
                        .font(.system(size: 20, weight: .medium, design: .rounded))
                        .padding(.horizontal)
                    Spacer()
                }
                MainListView(isMypage: true)
                Button {
                    logout = true
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 150, height: 50)
                        .foregroundColor(.white)
                        .overlay(
                            Text("로그아웃")
                        )
                }
            }
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
