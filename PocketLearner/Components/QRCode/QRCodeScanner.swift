//
//  QRCodeScanner.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/11.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import AVFoundation
import FirebaseFirestore

struct QRCodeScannerView: UIViewControllerRepresentable {
    @Binding var QRScanResult: scanResult
    @EnvironmentObject var user: userData
    
    var completionHandler: (String, String) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler, user: user, QRScanResult: $QRScanResult)
    }
    
    func makeUIViewController(context: Context) -> QRCodeScannerViewController {
        let viewController = QRCodeScannerViewController(user: user, QRScanResult: $QRScanResult)
        viewController.delegate = context.coordinator
        
        // 화면에 메시지를 띄우는 코드
        let messageLabel = UILabel()
        messageLabel.text = "상대의 QR코드를 스캔하세요!"
        messageLabel.font = UIFont.boldSystemFont(ofSize: 28)
        messageLabel.textColor = .white
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        viewController.view.addSubview(messageLabel)
        
        NSLayoutConstraint.activate([
            messageLabel.centerXAnchor.constraint(equalTo: viewController.view.centerXAnchor),
            messageLabel.centerYAnchor.constraint(equalTo: viewController.view.centerYAnchor, constant: -180),
            messageLabel.widthAnchor.constraint(equalTo: viewController.view.widthAnchor, multiplier: 0.8)
        ])
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: QRCodeScannerViewController, context: Context) {}
    
    class Coordinator: NSObject, QRCodeScannerViewControllerDelegate {
        var completionHandler: (String, String) -> Void
        var user: userData
        @Binding var QRScanResult: scanResult
        
        init(_ completionHandler: @escaping (String, String) -> Void, user: userData, QRScanResult: Binding<scanResult>) {
            self.completionHandler = completionHandler
            self.user = user
            self._QRScanResult = QRScanResult
        }
        
        func qrCodeScannerViewController(_ viewController: QRCodeScannerViewController, didScanCode code: String, counterpartID: String) {
            completionHandler(code, counterpartID)
        }
    }
}


protocol QRCodeScannerViewControllerDelegate: AnyObject {
    func qrCodeScannerViewController(_ viewController: QRCodeScannerViewController, didScanCode code: String, counterpartID: String)
}

class QRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: QRCodeScannerViewControllerDelegate?
    
    var user: userData  // SwiftUI의 @EnvironmentObject 대신 일반 Swift 객체 사용 (UIKit)
    @Binding var QRScanResult: scanResult
    
    // Add an initializer to receive the binding
    init(user: userData, QRScanResult: Binding<scanResult>) {
        self.user = user
        self._QRScanResult = QRScanResult
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var captureSession: AVCaptureSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            failedToConfigureSession()
            return
        }
        
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            failedToConfigureSession()
            return
        }
        
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        } else {
            failedToConfigureSession()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failedToConfigureSession()
            return
        }
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
    }
    
    
    
    func failedToConfigureSession() {
        let alertController = UIAlertController(title: "Scanning not supported", message: "Your device does not support QR code scanning.", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
        captureSession = nil
        QRScanResult = .fail
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.global(qos: .userInitiated).async {
            if let captureSession = self.captureSession, !captureSession.isRunning {
                captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let captureSession = captureSession, captureSession.isRunning {
            captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first,
           let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
           let stringValue = readableObject.stringValue {
            let components = stringValue.components(separatedBy: "|")
            if components.count == 3 {
                let uuid = components[0]
                let counterpartID = components[1]
                let createTime = Double(components[2]) ?? 0
                let currentTime = Date().timeIntervalSince1970
                let timeDifference = currentTime - createTime
                
                print("Scanned QR Code: \(stringValue)")
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                self.delegate?.qrCodeScannerViewController(self, didScanCode: uuid, counterpartID: counterpartID)
                
                if timeDifference <= 10 {
                    changeCard(counterpartID: counterpartID)
                } else {
                    print("QR Code Expired")
                    QRScanResult = .expired
                }
            }
        }
        
        self.dismiss(animated: true)
    }
    
    func changeCard(counterpartID: String){
        let myID: String = user.id
        
        // Firestore batch를 이용 - 단일 commit으로 2개의 Document 생성.
        let batch = db.batch()

        // myID = id1, counterpartID = id2 인 document 생성
        let docRef: DocumentReference = db.collection("CardExchangeHistory").document("\(myID)_\(counterpartID)")
        batch.setData(["id1" : myID,
                       "id2" : counterpartID,
                       "exchangeDate" : Timestamp(date: Date())], forDocument: docRef)

        // counterpartID = id1, myID = id2 인 document 생성
        let docRef2: DocumentReference = db.collection("CardExchangeHistory").document("\(counterpartID)_\(myID)")
        batch.setData(["id1" : counterpartID,
                       "id2" : myID,
                       "exchangeDate" : Timestamp(date: Date())], forDocument: docRef2)

        // 배치 쓰기 커밋
        batch.commit { (error) in
            if let error = error {
                // 오류 발생 시 처리
                print("명함 교환 실패(DB 업로드): \(error) - QRCodeScanner")
                self.QRScanResult = .dbFail
            } else {
                // 성공 시 처리
                print("명함 교환 성공! \(myID), \(counterpartID) - QRCodeScanner")
                self.QRScanResult = .success
            }
        }
    }
}
