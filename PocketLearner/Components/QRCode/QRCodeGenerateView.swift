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

struct QRCodeGenerateView: View {
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
