//
//  HeaderView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/10.
//

import SwiftUI
import UIKit

struct HeaderView: View {
    
    var isMain = false
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var moveToMy = false
    @EnvironmentObject var userVM: UserVM
    var body: some View {
        HStack {
            Text(UserDefaultsManager.shared.getClubName())
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
                .frame(width: screenWidth / 3)
            Spacer()
            if(isMain) {
                Button {
                    moveToMy.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.green.opacity(0.8))
                        .overlay(
                        Text("My page").font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                    )
                }
                .frame(width: 120, height: 40)
                .sheet(isPresented: $moveToMy) {
                    MyPageView()
                }
                .padding()
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
