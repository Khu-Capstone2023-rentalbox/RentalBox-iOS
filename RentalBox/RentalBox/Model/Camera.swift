//
//  Camera.swift
//  RentalBox
//
//  Created by MBSoo on 2023/05/20.
//
import Foundation
import AVFoundation
import UIKit
import Alamofire

class Camera: NSObject, ObservableObject {
    var session = AVCaptureSession()
    var videoDeviceInput: AVCaptureDeviceInput!
    let output = AVCapturePhotoOutput()
    var photoData = Data(count: 0)
    var isSilentModeOn = false
    var isReturn:Bool
    var flashMode: AVCaptureDevice.FlashMode = .off
    
    @Published var isCameraBusy = false
    @Published var recentImage: UIImage?
    @Published var uploadResponse: Rent?
    
    init(isReturn: Bool) {
        self.isReturn = isReturn
    }
    // 카메라 셋업 과정을 담당하는 함수, positio
    func setUpCamera() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                for: .video, position: .back) {
            do { // 카메라가 사용 가능하면 세션에 input과 output을 연결
                videoDeviceInput = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(videoDeviceInput) {
                    session.addInput(videoDeviceInput)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                    output.isHighResolutionCaptureEnabled = true
                    output.maxPhotoQualityPrioritization = .quality
                }
                session.startRunning() // 세션 시작
            } catch {
                print(error) // 에러 프린트
            }
        }
    }
    
    func requestAndCheckPermissions() {
        // 카메라 권한 상태 확인
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            // 권한 요청
            AVCaptureDevice.requestAccess(for: .video) { [weak self] authStatus in
                if authStatus {
                    DispatchQueue.main.async {
                        self?.setUpCamera()
                    }
                }
            }
        case .restricted:
            break
        case .authorized:
            // 이미 권한 받은 경우 셋업
            setUpCamera()
        default:
            // 거절했을 경우
            print("Permession declined")
        }
    }
    func capturePhoto() {
        // 사진 옵션 세팅
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = self.flashMode
        
        self.output.capturePhoto(with: photoSettings, delegate: self)
        print("[Camera]: Photo's taken")
    }
    func savePhoto(_ imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        // 사진 저장하기
        print("[Camera]: Photo's saved")
    }
    func uploadPhoto(imageData: Data) {
        let url = URL(string: "http://www.rentalbox.store/items/rent")
        print("rent Photo", url)
        let token = UserDefaultsManager.shared.getTokens()
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageData, withName: "picture", fileName: "picture", mimeType: "image/jpeg")
        },to: url!, method: .post, headers: [ "x-access-token": token.accessToken, "Content-Type": "multipart/form-data"])
        .responseDecodable(of: Rent.self, completionHandler: { response in
            switch response.result {
            case .success(let response):
                self.uploadResponse = response
            case .failure(let error):
                print(error.responseCode)
                print(error)
            }
        })
    }
    
    func returnPhoto(imageData: Data){
        let url = URL(string: "http://www.rentalbox.store/items/return")
        print("return Photo", url)
        let token = UserDefaultsManager.shared.getTokens()
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(imageData, withName: "picture", fileName: "picture", mimeType: "image/jpeg")
        },to: url!, method: .post, headers: [ "x-access-token": token.accessToken, "Content-Type": "multipart/form-data"])
        .response { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension Camera: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, willBeginCaptureFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        self.isCameraBusy = true
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, willCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            print("[Camera]: Silent sound activated")
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didCapturePhotoFor resolvedSettings: AVCaptureResolvedPhotoSettings) {
        if isSilentModeOn {
            AudioServicesDisposeSystemSoundID(1108)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let imageData = photo.fileDataRepresentation() else { return }
        self.recentImage = UIImage(data: imageData)
        if(isReturn) {
            print("returnPhoto")
            self.returnPhoto(imageData: imageData)
        } else {
            print("uploadPhoto")
            self.uploadPhoto(imageData: imageData)
        }
        self.savePhoto(imageData)
        
        print("[CameraModel]: Capture routine's done")
        
        self.isCameraBusy = false
    }
}
