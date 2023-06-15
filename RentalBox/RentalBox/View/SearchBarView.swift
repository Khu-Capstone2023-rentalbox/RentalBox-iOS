//
//  SearchBarView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/17.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var inputText: String
    var body: some View {
        VStack {
            TextField("검색어를 입력해주세요.", text: $inputText)
                .padding(5)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .textFieldStyle(.roundedBorder)
                .shadow(radius: 3)
        }
    }
}

//struct SearchBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchBarView()
//    }
//}
