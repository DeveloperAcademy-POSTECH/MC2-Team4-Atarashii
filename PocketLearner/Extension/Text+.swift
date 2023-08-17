//
//  Text+.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/08/16.
//

import SwiftUI

extension Text {
    func largeTitleFont() -> some View {
        self.font(.system(size: 20 * setFontSize(), weight: .bold))
            .lineSpacing(40.5)
    }
    func titleFont() -> some View {
        self.font(.system(size: 20 * setFontSize(), weight: .bold))
            .lineSpacing(31)
    }
    func semiBodyFont() -> some View {
        self.font(.system(size: 16 * setFontSize(), weight: .semibold))
            .lineSpacing(25)
    }
    func boldBodyFont() -> some View {
        self.font(.system(size: 16 * setFontSize(), weight: .bold))
            .lineSpacing(25)
    }
    func navigationFont() -> some View {
        self.font(.system(size: 16 * setFontSize(), weight: .medium))
            .lineSpacing(25)
    }
    func buttonFont() -> some View {
        self.font(.system(size: 15 * setFontSize(), weight: .semibold))
            .lineSpacing(25)
    }
    func calloutFont() -> some View {
        self.font(.system(size: 14 * setFontSize(), weight: .medium))
            .lineSpacing(20.3)
    }
    func labelFont() -> some View {
        self.font(.system(size: 12 * setFontSize(), weight: .semibold))
            .lineSpacing(20.5)
    }
    func captionFont() -> some View {
        self.font(.system(size: 10 * setFontSize(), weight: .bold))
            .lineSpacing(18)
    }
    
    // MARK: Screen의 해상도에 따른 대략적인 폰트 사이즈 비율 변경 (Screen의 height 사용.)
    func setFontSize() -> Double {
        let height = UIScreen.screenHeight
        var size = 1.0
        
        switch height {
        case 480.0: // Iphone 3,4S => 3.5 inch
            size = 0.85
        case 568.0: // iphone 5, SE => 4 inch
            size = 0.9
        case 667.0: // iphone 6, 6s, 7, 8 => 4.7 inch
            size = 0.9
        case 736.0: // iphone 6s+ 6+, 7+, 8+ => 5.5 inch
            size = 0.95
        case 812.0: // iphone X, XS => 5.8 inch, 13 mini, 12, mini
            size = 0.98
        case 844.0: // iphone 14, iphone 13 pro, iphone 13, 12 pro, 12
            size = 1
        case 852.0: // iphone 14 pro
            size = 1
        case 926.0: // iphone 14 plus, iphone 13 pro max, 12 pro max
            size = 1.05
        case 896.0: // iphone XR => 6.1 inch  // iphone XS MAX => 6.5 inch, 11 pro max, 11
            size = 1.05
        case 932.0: // iPhone14 Pro Max
            size = 1.08
        default:
            size = 1
        }
        return size
    }
}
