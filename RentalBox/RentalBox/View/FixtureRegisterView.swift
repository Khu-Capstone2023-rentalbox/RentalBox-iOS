//
//  SwiftUIView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/28.
//

import SwiftUI

let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .none
    formatter.zeroSymbol  = ""
    return formatter
}()

struct FixtureRegisterView: View {
    @EnvironmentObject var userVM: UserVM
    @EnvironmentObject var networking: FixtureViewModel
    @FocusState var isFocused: Bool
    @State var bookName = ""
    @State var bookCount = 0
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    let url = "http://www.rentalbox.store/items"
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text(UserDefaultsManager.shared.getClubName())
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                    Spacer()
                }
                .padding()
                Text("물품 등록")
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                    .padding()
                HStack {
                    Text("물품명 :")
                        .padding()
                    TextField("물품의 이름을 입력해주세요.", text: $bookName)
                        .focused($isFocused)
                        
                }
                .frame(height: 50)
                .background(in: RoundedRectangle(cornerRadius: 10))
                .padding()
                HStack {
                    Text("개수 :")
                        .padding()
                    TextField("개수를 입력해주세요.", value: $bookCount, formatter: numberFormatter)
                        .textContentType(.oneTimeCode)
                        .keyboardType(.decimalPad)
                        .offset(x:15)
                        .focused($isFocused)
                }
                .frame(height: 50)
                .background(in: RoundedRectangle(cornerRadius: 10))
                .padding()
                Button {
                    networking.alamofireFixtureUpload(url: url, itemName: bookName, count: bookCount)
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width:120, height: 50)
                        .foregroundColor(.white)
                        .overlay(
                            Text("등록하기")
                                .foregroundColor(.green.opacity(0.8))
                        )
                }
                .padding()
                Button {
                    networking.alamofireNetworking(url: "http://www.rentalbox.store")
                    self.presentationMode.wrappedValue.dismiss()
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width:120, height: 50)
                        .foregroundColor(.white)
                        .overlay(
                            Text("확인")
                                .foregroundColor(.green.opacity(0.8))
                        )
                }
            }
            

        }.onTapGesture {
            isFocused = false
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        FixtureRegisterView()
    }
}
