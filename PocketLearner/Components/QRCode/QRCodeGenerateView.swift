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
    @State private var isQRCodeExpired = false
    @State private var timer: Timer?
    @State private var timeRemaining = 10
    @State private var qrCodeTimestamp = Date().timeIntervalSince1970
    @Binding var isQRCodePresented: Bool
    @Binding var QRAnimation: Bool
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button(action: {
                    withAnimation(.linear(duration: 0.5)) {
                        isQRCodePresented = false
                    }
                        QRAnimation = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }.padding(.top, 50)
            }
            Text(timeRemaining == 0 ? "QR코드가 만료되었습니다" : "\(timeRemaining) 초 후 QR코드가 만료됩니다")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(mainAccentColor)
                .padding(.bottom, 20).padding(.top, 10)
            
            QRCodeView(timestamp: qrCodeTimestamp)
            
            cardGenerateViewsButton(title: "QR코드 재생성", disableCondition: !isQRCodeExpired, action: {
                isQRCodeExpired = false
                timeRemaining = 10
                qrCodeTimestamp = Date().timeIntervalSince1970
                startTimer()
            }).padding(.top, 30).padding(.bottom, 50)
        }.background(.white)
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
