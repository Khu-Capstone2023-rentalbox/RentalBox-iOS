//
//  CameraView.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/20.
//

import SwiftUI

struct CameraView: View {
    @ObservedObject var viewModel = CameraViewModel(isReturn: false)
    var isReturn: Bool
    init(isReturn: Bool) {
        self.isReturn = isReturn
        self.viewModel.isReturn = isReturn
        print("set Return", isReturn)
    }
    var body: some View {
        ZStack {
            viewModel.cameraPreview.ignoresSafeArea()
            VStack {
                HStack {
                    // 셔터사운드 온오프
                    Button(action: {viewModel.switchSilent()}) {
                        Image(systemName: viewModel.isSilentModeOn ?
                              "speaker.fill" : "speaker")
                        .foregroundColor(viewModel.isSilentModeOn ? .yellow : .white)
                    }
                    .padding(.horizontal, 30)
                    
                    // 플래시 온오프
                    Button(action: {viewModel.switchFlash()}) {
                        Image(systemName: viewModel.isFlashOn ?
                              "bolt.fill" : "bolt")
                        .foregroundColor(viewModel.isFlashOn ? .yellow : .white)
                    }
                    .padding(.horizontal, 30)
                }
                .font(.system(size:25))
                .padding()
                
                Spacer()
                
                HStack{
                    Button(action: {}) {
                        if let previewImage = viewModel.recentImage {
                            Image(uiImage: previewImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .aspectRatio(1, contentMode: .fit)
                        } else {
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(lineWidth: 3)
                                .foregroundColor(.white)
                                .frame(width: 75, height: 75)
                        }
                    }
                    .padding()
                    
                    Spacer()
                    
                    // 사진찍기 버튼
                    Button(action: {
                        viewModel
                        viewModel.capturePhoto()}) {
                        Circle()
                            .stroke(lineWidth: 5)
                            .frame(width: 75, height: 75)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // 전후면 카메라 교체
                    Button(action: {viewModel.changeCamera()}) {
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        
                    }
                    .frame(width: 75, height: 75)
                    .padding()
                }
            }
            .foregroundColor(.white)
        }
        .opacity(viewModel.shutterEffect ? 0 : 1)
        .onAppear(
            perform: self.viewModel.configure
        )
    }
}

//struct CameraView_Previews: PreviewProvider {
//    static var previews: some View {
//        CameraView()
//    }
//}
