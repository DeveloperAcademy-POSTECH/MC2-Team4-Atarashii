//
//  CommunicationStyleCard.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/05/12.
//

import SwiftUI

struct CommunicationStyleCardBack: View {
    @Binding var degree : Double
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 18.17)
                .fill(.white)
                .frame(width: 138.63, height: 210.34)
                .shadow(color: .black.opacity(0.25), radius: 6.09, x: 0, y: 2)
            Image("communicationStyleCardPattern")
                .resizable()
                .frame(width:129.07, height: 200.78)
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        
    }
}

struct CommunicationStyleCardFront: View {
    @Binding var degree : Double
    @Binding var typeTitle: String
    @Binding var typeEnglishDescription: String
    @Binding var typeDescription: String
    @Binding var typeImageTitle: String
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18.17)
                .fill(.white)
                .frame(width: 138.63, height: 210.34)
                .shadow(color: .black.opacity(0.25), radius: 6.09, x: 0, y: 2)
            
            VStack(spacing: 0) {
                Image(typeImageTitle)
                    .resizable()
                .frame(width:64.97, height: 79.94)
                
                Text(typeTitle)
                    .font(.system(size: 14, weight: .bold))
                    .padding(.top, 23)
                
                Text(typeEnglishDescription)
                    .font(.system(size: 7.64, weight: .regular))

                
                Text(typeDescription)
                    .font(.system(size: 6.84, weight: .regular))
                    .padding(.top, 12)
                    .multilineTextAlignment(.center)
            }
            
           }
            //.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        }
        
}


