//
//  IntroView.swift
//  bletest
//
//  Created by 주환 on 2023/05/08.
//

import SwiftUI

struct IntroView : View {
    
    var body: some View {
        Image("dummyPikachu")
            .resizable()
            .imageScale(.large)
            .frame(width: 300,height: 300)
    }
    
}


struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView().previewDevice("iPhone 14")
    }
}


