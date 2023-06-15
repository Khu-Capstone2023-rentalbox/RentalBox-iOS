//
//  ClubRegisterView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/04/27.
//

import SwiftUI
import UIKit
import FilePicker
import Alamofire
import UniformTypeIdentifiers

var stringFormatter: PersonNameComponentsFormatter = {
    let formatter = PersonNameComponentsFormatter()
    
    
    return formatter
}()

struct ListViewModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        content.scrollContentBackground(.hidden)
    }
}

var arrayDict = ["2019102168", "2019102169", "2019102170", "2019102171", "2019102172", "2019102173", "2019102174", "2019102175", "2019102176", "2019102177", "2019102178", "2019102179", "2019102180", "2019102181"]

struct ClubRegisterView: View {
    @State var clubName: String = ""
    @State var openFile = false
    @State var uploadComplete = false
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    @ObservedObject var networkingClub = ClubViewModel()
    @StateObject var networking = FixtureViewModel()
    var body: some View {
        ZStack {
            Color.gray.opacity(0.4)
                .ignoresSafeArea()
            VStack {
                HStack {
                    Text("동아리 명:")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .padding()
                    TextField("동아리 명을 입력해주세요.", text: $clubName)
                }
                .background(in: RoundedRectangle(cornerRadius: 10))
                .padding()
                HStack {
                    Text("동아리원 명단")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                    Spacer()
                    Button {
                        openFile.toggle()
                    } label: {
                        HStack {
                            Text("엑셀 파일을 선택해주세요.")
                            Image(systemName: "square.and.arrow.up.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color.green.opacity(0.6))
                        }
                            
                    }.fileImporter(isPresented: $openFile, allowedContentTypes: [UTType.init(mimeType: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")!]) { result in
                        do {
                            let fileURL = try result.get()
                            let url = try fileURL.asURL()
                            print(fileURL)
                            networkingClub.uploadFile(fileURL: url, clubName: clubName)
                            uploadComplete = true
                        } catch {
                            
                        }
                    }
                }.padding()
                
                List(arrayDict, id:\.self) { row in
                    Text(row).foregroundColor(uploadComplete ? .black :.clear )
                }
                .listStyle(.insetGrouped)
                .frame(height: screenHeight / 2)
                .modifier(ListViewModifier())
                
                
                NavigationLink {
                    MainView(networking: networking)
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .overlay (
                            Text("동아리 등록")
                        )
                        .frame(width: screenWidth / 2, height: 50)
                }
            }
        }
    }
    
}

struct ClubRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ClubRegisterView()
    }
}
