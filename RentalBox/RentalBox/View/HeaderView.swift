//
//  HeaderView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/10.
//

import SwiftUI
import UIKit

struct HeaderView: View {
    let clubName = "D.Com"
    var isMain = false
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var moveToMy = false
    var body: some View {
        HStack {
            Text(clubName)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .padding()
                .frame(width: screenWidth / 3)
            Spacer()
            if(isMain) {
                Button {
                    moveToMy.toggle()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.green)
                        .overlay(
                        Text("MY").font(.system(size: 30, weight: .bold, design: .rounded))
                            .foregroundColor(.black)
                    )
                }
                .frame(width: screenWidth / 3)
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
