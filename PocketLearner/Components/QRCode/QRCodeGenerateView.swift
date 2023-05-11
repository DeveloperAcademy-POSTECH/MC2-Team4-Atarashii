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
            VStack {
                Text(timeRemaining == 0 ? "QR코드가 만료되었습니다" : "\(timeRemaining) 초 후 QR코드가 만료됩니다")
                    .font(.callout)
                    .foregroundColor(.red)
                QRCodeView(timestamp: qrCodeTimestamp)
                Button("Regenerate QR Code") {
                    isQRCodeExpired = false
                    timeRemaining = 10
                    qrCodeTimestamp = Date().timeIntervalSince1970
                    startTimer()
                }
                .disabled(!isQRCodeExpired)
            }
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
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
    @EnvironmentObject var user: userData
    
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
        let myID = user.id
        let combinedString = "\(uuid)|\(myID)|\(timestamp)"
        let data = Data(combinedString.utf8)
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage,
           let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
            return UIImage(cgImage: cgImage)
        }

        return nil
    }
}
