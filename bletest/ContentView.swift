//
//  ContentView.swift
//  bletest
//
//  Created by 이재원 on 2023/05/05.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import AVFoundation
import FirebaseFirestore

struct ContentView: View {
    @State private var isShowingScanner = false
    @State private var isShowingAlert = false
    @State private var scannedDeviceName = ""
    @State private var isQRCodeExpired = false
    @State private var timer: Timer?
    @State private var timeRemaining = 10
    @State private var qrCodeTimestamp = Date().timeIntervalSince1970

    var body: some View {
        NavigationView {
            VStack {
                Text("Scanned device: \(scannedDeviceName)")
                    .padding()
                    .font(.headline)
                Text("\(timeRemaining) seconds remaining")
                    .font(.callout)
                    .foregroundColor(.red)
                if isQRCodeExpired {
                    Text("만료되었습니다")
                        .foregroundColor(.red)
                        .font(.headline)
                }
                QRCodeView(timestamp: qrCodeTimestamp)
                Button("Scan QR Code") {
                    isShowingScanner.toggle()
                }
                .sheet(isPresented: $isShowingScanner) {
                    QRCodeScannerView(scannedDeviceName: $scannedDeviceName) { code, deviceName in
                        isShowingScanner = false
                        if code == UIDevice.current.identifierForVendor?.uuidString {
                            scannedDeviceName = deviceName
                            isShowingAlert = true
                        }
                    }
                }.padding(.bottom, 20)
                Button("Regenerate QR Code") {
                    isQRCodeExpired = false
                    timeRemaining = 10
                    qrCodeTimestamp = Date().timeIntervalSince1970
                    startTimer()
                }
                .disabled(!isQRCodeExpired)
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("QR Code Scanned"), message: Text("Scanned device: \(scannedDeviceName)"), dismissButton: .default(Text("OK")))
            }
            .navigationBarTitle("QR Code")
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
        }
    }

    func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                isQRCodeExpired = true
                timer.invalidate()
            }
        }
    }
}

struct QRCodeView: View {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    let timestamp: TimeInterval

    var body: some View {
        if let image = generateQRCodeImage() {
            Image(uiImage: image)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
        } else {
            Text("Failed to generate QR Code")
        }
    }

    func generateQRCodeImage() -> UIImage? {
        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
        let deviceName = UIDevice.current.name
        let combinedString = "\(uuid)|\(deviceName)|\(timestamp)"
        let data = Data(combinedString.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return nil
    }
}


struct QRCodeScannerView: UIViewControllerRepresentable {
    @Binding var scannedDeviceName: String
    
    var completionHandler: (String, String) -> Void
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(completionHandler)
    }
    
    func makeUIViewController(context: Context) -> QRCodeScannerViewController {
        let viewController = QRCodeScannerViewController(scannedDeviceName: $scannedDeviceName)
        viewController.delegate = context.coordinator
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: QRCodeScannerViewController, context: Context) {}
    
    class Coordinator: NSObject, QRCodeScannerViewControllerDelegate {
        var completionHandler: (String, String) -> Void
        
        init(_ completionHandler: @escaping (String, String) -> Void) {
            self.completionHandler = completionHandler
        }
        
        func qrCodeScannerViewController(_ viewController: QRCodeScannerViewController, didScanCode code: String, deviceName: String) {
            completionHandler(code, deviceName)
        }
    }
}

protocol QRCodeScannerViewControllerDelegate: AnyObject {
    func qrCodeScannerViewController(_ viewController: QRCodeScannerViewController, didScanCode code: String, deviceName: String)
}

class QRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: QRCodeScannerViewControllerDelegate?
    @Binding var scannedDeviceName: String
    
    // Add an initializer to receive the binding
    init(scannedDeviceName: Binding<String>) {
        self._scannedDeviceName = scannedDeviceName
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
                let deviceName = components[1]
                let createTime = Double(components[2]) ?? 0
                let currentTime = Date().timeIntervalSince1970
                let timeDifference = currentTime - createTime
                
                print("Scanned QR Code: \(stringValue)")
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                self.delegate?.qrCodeScannerViewController(self, didScanCode: uuid, deviceName: deviceName)
                
                if timeDifference <= 10 {
                    self.scannedDeviceName = deviceName
                    changeCard(deviceName: deviceName)
                } else {
                    print("QR Code Expired")
                    self.scannedDeviceName = "스캔한 QR이 만료되었습니다."
                }
            }
        }
        
        self.dismiss(animated: true)
    }
    
    func changeCard(deviceName: String){
        let db = Firestore.firestore()
        
        let myDeviceName:String = UIDevice.current.name
        
        // Add a new document with a generated ID
        let docRef: DocumentReference = db.collection("CardExchangeHistory").document("\(myDeviceName)_\(deviceName)")
        
        docRef.setData(["userID1" : myDeviceName,
                        "userID2" : deviceName,
                        "exchangeDate" : Timestamp(date: Date())]) { error in
            if let error = error {
                // 오류 발생 시 처리
                print("Error writing document: \(error)")
            } else {
                // 성공 시 처리
                print("\(myDeviceName) and \(deviceName) exchange card successfully!")
            }
        }
    }
}
