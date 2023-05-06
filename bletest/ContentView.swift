//
//  ContentView.swift
//  bletest
//
//  Created by 이재원 on 2023/05/05.
//
//
//import SwiftUI
//import MultipeerConnectivity
//
//struct ContentView: View {
//    @ObservedObject var multipeerHandler = MultipeerHandler()
//
//    var body: some View {
//        NavigationView {
//            List(multipeerHandler.connectedPeers, id: \.displayName) { peer in
//                Text(peer.displayName)
//            }
//            .navigationBarTitle("Nearby Devices")
//        }
//        .onAppear {
//            multipeerHandler.setup()
//        }
//    }
//}
//
//class MultipeerHandler: NSObject, ObservableObject {
//    private let serviceType = "myapp-service"
//    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
//    private var session: MCSession!
//    private var advertiser: MCNearbyServiceAdvertiser!
//    private var browser: MCNearbyServiceBrowser!
//
//    @Published var connectedPeers: [MCPeerID] = []
//
//    func setup() {
//        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .required)
//        session.delegate = self
//
//        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: serviceType)
//        advertiser.delegate = self
//        advertiser.startAdvertisingPeer()
//
//        browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
//        browser.delegate = self
//        browser.startBrowsingForPeers()
//    }
//}
//
//extension MultipeerHandler: MCSessionDelegate {
//    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
//        DispatchQueue.main.async {
//            if state == .connected {
//                self.connectedPeers.append(peerID)
//            } else {
//                self.connectedPeers.removeAll { $0 == peerID }
//            }
//        }
//    }
//
//    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {}
//    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
//    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
//    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
//}
//
//extension MultipeerHandler: MCNearbyServiceAdvertiserDelegate {
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//        invitationHandler(true, session)
//    }
//
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
//        print("Error: \(error.localizedDescription)")
//    }
//}
//
//extension MultipeerHandler: MCNearbyServiceBrowserDelegate {
//    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
//        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
//    }
//
//    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        DispatchQueue.main.async {
//            self.connectedPeers.removeAll { $0 == peerID }
//        }
//    }
//
//    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
//        print("Error: \(error.localizedDescription)")
//    }
//}


//------------------
//
//import SwiftUI
//import MultipeerConnectivity
//import NearbyInteraction
//
//struct ContentView: View {
//    @ObservedObject var multipeerHandler = MultipeerHandler()
//    
//    var body: some View {
//        NavigationView {
//            List(multipeerHandler.connectedPeers) { peer in
//                VStack(alignment: .leading) {
//                    Text(peer.peerID.displayName)
//                    
//                    if let distance = peer.distance {
//                        Text("Distance: \(distance) meters")
//                            .font(.footnote)
//                            .foregroundColor(.gray)
//                    }
//                }
//            }
//            .navigationBarTitle("Nearby Devices")
//        }
//        .onAppear {
//            multipeerHandler.setup()
//            multipeerHandler.setupNearbyInteraction()
//        }
//    }
//}
//
//struct NINearbyPeer: Identifiable {
//    let id = UUID()
//    let peerID: MCPeerID
//    let discoveryToken: NIDiscoveryToken
//    var distance: Float?
//}
//
//class MultipeerHandler: NSObject, ObservableObject {
//    private let serviceType = "myapp-service"
//    private let myPeerID = MCPeerID(displayName: UIDevice.current.name)
//    private var session: MCSession!
//    private var advertiser: MCNearbyServiceAdvertiser!
//    private var browser: MCNearbyServiceBrowser!
//    private var nearbySession: NISession!
//    
//    @Published var connectedPeers: [NINearbyPeer] = []
//    
//    func setup() {
//        session = MCSession(peer: myPeerID, securityIdentity: nil, encryptionPreference: .required)
//        session.delegate = self
//        
//        advertiser = MCNearbyServiceAdvertiser(peer: myPeerID, discoveryInfo: nil, serviceType: serviceType)
//        advertiser.delegate = self
//        advertiser.startAdvertisingPeer()
//        
//        browser = MCNearbyServiceBrowser(peer: myPeerID, serviceType: serviceType)
//        browser.delegate = self
//        browser.startBrowsingForPeers()
//    }
//    
//    func setupNearbyInteraction() {
//        nearbySession = NISession()
//        nearbySession.delegate = self
//    }
//    
//    func updateNearbyInteractionConfig() {
//        let tokens = connectedPeers.map { $0.discoveryToken } [0]
//        let config = NINearbyPeerConfiguration(peerToken: tokens)
//        nearbySession.run(config)
//    }
//}
//
//extension MultipeerHandler: MCSessionDelegate {
//    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
//        DispatchQueue.main.async {
//            if state == .connected {
//                if let discoveryToken = NISession().discoveryToken,
//                   let data = try? NSKeyedArchiver.archivedData(withRootObject: discoveryToken, requiringSecureCoding: true) {
//                    try? session.send(data, toPeers: [peerID], with: .reliable)
//                }
//            } else {
//                self.connectedPeers.removeAll { $0.peerID == peerID }
//            }
//        }
//    }
//    
//    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
//        if let token = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) {
//            DispatchQueue.main.async {
//                let nearbyPeer = NINearbyPeer(peerID: peerID, discoveryToken: token)
//                self.connectedPeers.append(nearbyPeer)
//                self.updateNearbyInteractionConfig()
//            }
//        }
//    }
//    
//    func session(_ session: MCSession, didReceive stream:InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
//    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {}
//    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {}
//}
//
//extension MultipeerHandler: MCNearbyServiceAdvertiserDelegate {
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
//        invitationHandler(true, session)
//    }
//    
//    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
//        print("Error: \(error.localizedDescription)")
//    }
//}
//
//extension MultipeerHandler: MCNearbyServiceBrowserDelegate {
//    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
//        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
//    }
//    
//    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
//        DispatchQueue.main.async {
//            self.connectedPeers.removeAll { $0.peerID == peerID }
//        }
//    }
//    
//    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
//        print("Error: \(error.localizedDescription)")
//    }
//}
//
//extension MultipeerHandler: NISessionDelegate {
//    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
//        DispatchQueue.main.async {
//            for object in nearbyObjects {
//                if let index = self.connectedPeers.firstIndex(where: { $0.discoveryToken == object.discoveryToken }) {
//                    self.connectedPeers[index].distance = object.distance
//                }
//            }
//        }
//    }
//}
//

//-------

//import SwiftUI
//import NearbyInteraction
//
//struct ContentView: View {
//    @ObservedObject var nearbyInteractionHandler = NearbyInteractionHandler()
//
//    var body: some View {
//        NavigationView {
//            List(nearbyInteractionHandler.deviceInfos) { deviceInfo in
//                VStack(alignment: .leading) {
//                    Text(deviceInfo.name)
//                    if let distance = deviceInfo.distance {
//                        Text("Distance: \(distance) meters")
//                    } else {
//                        Text("Distance: Unknown")
//                    }
//                }
//            }
//            .navigationBarTitle("Nearby Devices")
//        }
//        .onAppear {
//            nearbyInteractionHandler.setup()
//        }
//    }
//}
//
//struct DeviceInfo: Identifiable, Hashable {
//    let id: UUID
//    let name: String
//    let token: NIDiscoveryToken
//    var distance: Float?
//}
//
//class NearbyInteractionHandler: NSObject, ObservableObject {
//    private var session: NISession!
//
//    @Published var deviceInfos: [DeviceInfo] = []
//
//    func setup() {
//        session = NISession()
//        session.delegate = self
//
//        if let discoveryToken = session.discoveryToken {
//            let config = NINearbyPeerConfiguration(peerToken: discoveryToken)
//            session.run(config)
//        }
//    }
//
//    func addOrUpdateDevice(deviceToken: NIDiscoveryToken, distance: Float?) {
//        if let index = deviceInfos.firstIndex(where: { $0.token == deviceToken }) {
//            deviceInfos[index].distance = distance
//        } else {
//            let deviceInfo = DeviceInfo(id: UUID(), name: "Unknown", token: deviceToken, distance: distance)
//            deviceInfos.append(deviceInfo)
//        }
//    }
//}
//
//extension NearbyInteractionHandler: NISessionDelegate {
//    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
//        DispatchQueue.main.async {
//            for object in nearbyObjects {
//                self.addOrUpdateDevice(deviceToken: object.discoveryToken, distance: object.distance)
//            }
//        }
//    }
//
//    func sessionWasSuspended(_ session: NISession) {
//        print("Nearby Interaction session was suspended.")
//    }
//
//    func sessionSuspensionEnded(_ session: NISession) {
//        print("Nearby Interaction session suspension ended.")
//    }
//
//    func session(_ session: NISession, didInvalidateWith error: Error) {
//        print("Nearby Interaction session invalidated: \(error.localizedDescription)")
//    }
//}
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import AVFoundation
import FirebaseFirestore

//struct ContentView: View {
//    @State private var isShowingScanner = false
//    @State private var isShowingAlert = false
//    @State private var scannedDeviceName = ""
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Text("Scanned device: \(scannedDeviceName)")
//                    .padding()
//                    .font(.headline)
//                QRCodeView()
//                Button("Scan QR Code") {
//                    isShowingScanner.toggle()
//                }
//                .sheet(isPresented: $isShowingScanner) {
//                    QRCodeScannerView(scannedDeviceName: $scannedDeviceName) { code, deviceName in
//                        isShowingScanner = false
//                        if code == UIDevice.current.identifierForVendor?.uuidString {
//                            scannedDeviceName = deviceName
//                            isShowingAlert = true
//                        }
//                    }
//                }
//            }
//            .alert(isPresented: $isShowingAlert) {
//                Alert(title: Text("QR Code Scanned"), message: Text("Scanned device: \(scannedDeviceName)"), dismissButton: .default(Text("OK")))
//            }
//            .navigationBarTitle("QR Code")
//        }
//    }
//}
//
//
//struct QRCodeView: View {
//    let context = CIContext()
//    let filter = CIFilter.qrCodeGenerator()
//
//    var body: some View {
//        if let image = generateQRCodeImage() {
//            Image(uiImage: image)
//                .interpolation(.none)
//                .resizable()
//                .scaledToFit()
//        } else {
//            Text("Failed to generate QR Code")
//        }
//    }
//
//    func generateQRCodeImage() -> UIImage? {
//        let uuid = UIDevice.current.identifierForVendor?.uuidString ?? ""
//        let deviceName = UIDevice.current.name
//        let combinedString = "\(uuid)|\(deviceName)"
//        let data = Data(combinedString.utf8)
//        filter.setValue(data, forKey: "inputMessage")
//
//        if let outputImage = filter.outputImage,
//           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
//            return UIImage(cgImage: cgImage)
//        }
//
//        return nil
//    }
//
//}

struct ContentView: View {
    @State private var isShowingScanner = false
    @State private var isShowingAlert = false
    @State private var scannedDeviceName = ""
    @State private var isQRCodeExpired = false
    @State private var timer: Timer?
    @State private var timeRemaining = 10

    var body: some View {
        NavigationView {
            VStack {
                Text("Scanned device: \(scannedDeviceName)")
                    .padding()
                    .font(.headline)
                QRCodeView()
                Text("\(timeRemaining) seconds remaining")
                    .font(.callout)
                    .foregroundColor(.red)
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
                }
                Button("Regenerate QR Code") {
                    isQRCodeExpired = false
                    timeRemaining = 10
                    startTimer()
                }
                .disabled(!isQRCodeExpired)
                if isQRCodeExpired {
                    Text("만료되었습니다")
                        .foregroundColor(.red)
                        .font(.headline)
                }
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
        let combinedString = "\(uuid)|\(deviceName)"
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
            if components.count == 2 {
                let uuid = components[0]
                let deviceName = components[1]
                print("Scanned QR Code: \(stringValue)")
                AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
                self.delegate?.qrCodeScannerViewController(self, didScanCode: uuid, deviceName: deviceName)
                
                self.scannedDeviceName = deviceName
                changeCard(deviceName: deviceName)
            }
        }
        
        self.dismiss(animated: true)
    }
    
    func changeCard(deviceName: String){
        let db = Firestore.firestore()
        
        let myDeviceName:String = UIDevice.current.name
        
        // Add a new document with a generated ID
        var docRef: DocumentReference = db.collection("CardExchangeHistory").document("\(myDeviceName)_\(deviceName)")
        
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
        
        
        
        
        //        ref = db.collection("users").addDocument(data: [
        //            "first": "Ada",
        //            "last": "Lovelace",
        //            "born": 1815
        //        ]) { err in
        //            if let err = err {
        //                print("Error adding document: \(err)")
        //            } else {
        //                print("Document added with ID: \(ref!.documentID)")
        //            }
        //        }
    }
}
