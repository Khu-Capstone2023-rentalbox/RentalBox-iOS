//
//  MypageListView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/06/01.
//

import SwiftUI

struct MypageListView: View {
    @ObservedObject var networking: FixtureViewModel
    let url = "http://www.rentalbox.store/myItem-list"
    var body: some View {
        ScrollView {
            ForEach(networking.mypageData?.list ?? [], id:\.self) { row in
                HStack {
                    NavigationLink {
                        FixtureRentView(mypageList: row)
                    } label: {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.white)
                            .frame(height: 40)
                            .overlay(
                                HStack {
                                    Text(row.itemName)
                                        
                                    Spacer()
                                    Image(systemName: "arrow.forward")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 12)
                                }
                                    .padding()
                                    .foregroundColor(.teal)
                            )
                        
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
    }
}

//struct MypageListView_Previews: PreviewProvider {
//    static var previews: some View {
//        MypageListView()
//    }
//}
