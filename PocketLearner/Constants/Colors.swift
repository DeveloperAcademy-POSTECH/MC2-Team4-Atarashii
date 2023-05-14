//
//  Colors.swift
//  PocketLearner
//
//  Created by 이재원 on 2023/05/10.
//

import Foundation
import SwiftUI

// MainAccentColor
let mainAccentColor = Color("mainAccentColor")
let mainOrengeColor: Color = hexStringToColor(hexString: "FF722D")

// CommentView 측 Colors.
let textGrayColor: UIColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)            // #AAAAAA
let borderGrayColor: UIColor = #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1)          // #D8D8D8
let buttonDisabledGrayColor: UIColor = #colorLiteral(red: 0.8823529412, green: 0.8862745098, blue: 0.8862745098, alpha: 1)  // #E1E2E2
let buttonEditAbledPinkColor: UIColor = #colorLiteral(red: 0.9568627451, green: 0.6784313725, blue: 0.7019607843, alpha: 1) // #F4ADB3

let commentTextBlackColor: UIColor = #colorLiteral(red: 0.3450980186, green: 0.3450980186, blue: 0.3450980186, alpha: 1)    // #585858
let commentBoxGrayColor: UIColor = #colorLiteral(red: 0.9647058845, green: 0.9647058845, blue: 0.9647058845, alpha: 1)      // #F6F6F6
let dividerGrayColor: UIColor = #colorLiteral(red: 0.8509803922, green: 0.8509803922, blue: 0.8509803922, alpha: 1)         // #D9D9D9

// CardDetail
let gaugeGrayColor: Color = Color(red: 250/255, green: 250/255, blue: 250/255)
let radiusGrayColor: Color = Color(red: 0.6, green: 0.6, blue: 0.6)

let purpleColor1: Color = Color(red: 177/255, green: 140/255, blue: 254/255)
let purpleColor2: Color = Color(red: 0.749, green: 0.745, blue: 1.0)
let textGrayColor2: Color = Color(red: 137/255, green: 138/255, blue: 141/255)
let textPinkColor: Color = Color(red: 0.96, green: 0.68, blue: 0.70)
let textBackgroundGrayColor: Color = Color(red: 0.952, green: 0.952, blue: 0.952)   // #F3F3F3

// CardGenerate
let disabledNextButtonColor = #colorLiteral(red: 0.8797428608, green: 0.8797428012, blue: 0.8797428608, alpha: 1)
let strokeGray = #colorLiteral(red: 0.8549019608, green: 0.8549019608, blue: 0.8549019608, alpha: 1)        // #DADADA
let softPink = #colorLiteral(red: 0.9725490196, green: 0.7411764706, blue: 0.7529411765, alpha: 1)          // #F8BDC0
let unActivatedGray = #colorLiteral(red: 0.7490196078, green: 0.7490196078, blue: 0.7490196078, alpha: 1)   // #BFBFBF
let pickerEmptyGray = Color(#colorLiteral(red: 0.9053899646, green: 0.9086087942, blue: 0.9086763859, alpha: 1)) // #E1E2E2

let menuDefaultGray = Color(#colorLiteral(red: 0.9341433644, green: 0.9341433644, blue: 0.9341433644, alpha: 1)) //EAEAEA
let textDismissGray = Color(#colorLiteral(red: 0.6251094341, green: 0.6256788373, blue: 0.6430239081, alpha: 1))
let textFieldStrokeGray = Color(#colorLiteral(red: 0.9182699323, green: 0.9187726974, blue: 0.9341935515, alpha: 1))

// CardGenerate - SelectCollaborationKeyword

let collaborationKeywordColor_0 = Color(#colorLiteral(red: 0, green: 0.6354964972, blue: 0.4480856657, alpha: 1))
let collaborationKeywordColor_1 = Color(#colorLiteral(red: 0.9960784314, green: 0.4470588235, blue: 0.4470588235, alpha: 1))
let collaborationKeywordColor_2 = Color(#colorLiteral(red: 0.5019607843, green: 0.8549019608, blue: 0.5176470588, alpha: 1))
let collaborationKeywordColor_3 = Color(#colorLiteral(red: 0.9568627451, green: 0.6784313725, blue: 0.7019607843, alpha: 1))
let collaborationKeywordColor_4 = Color(#colorLiteral(red: 0, green: 0.7490196078, blue: 0.8509803922, alpha: 1))
let collaborationKeywordColor_5 = Color(#colorLiteral(red: 0.6941176471, green: 0.5490196078, blue: 0.9960784314, alpha: 1))
let collaborationKeywordColor_6 = Color(#colorLiteral(red: 1, green: 0.8078431373, blue: 0.3176470588, alpha: 1))
let collaborationKeywordColor_7 = Color(#colorLiteral(red: 0.9647058824, green: 0.5921568627, blue: 0.3803921569, alpha: 1))


// MARK: - 명함 컬러 값

let cardBackgroundColor_0 = Color(#colorLiteral(red: 0.9568627451, green: 0.6784313725, blue: 0.7019607843, alpha: 1))
let cardBackgroundColor_1 = Color(#colorLiteral(red: 1, green: 0.9490196078, blue: 0.4901960784, alpha: 1))
let cardBackgroundColor_2 = Color(#colorLiteral(red: 0.3882352941, green: 0.9254901961, blue: 1, alpha: 1))
let cardBackgroundColor_3 = Color(#colorLiteral(red: 0.7490196078, green: 0.7450980392, blue: 1, alpha: 1))
let cardBackgroundColor_4 = Color(#colorLiteral(red: 0.9843137255, green: 0.4549019608, blue: 0.4549019608, alpha: 1))
let cardBackgroundColor_5 = Color(#colorLiteral(red: 0.9647058824, green: 0.5921568627, blue: 0.3803921569, alpha: 1))
let cardBackgroundColor_6 = Color(#colorLiteral(red: 0.5019607843, green: 0.8549019608, blue: 0.5176470588, alpha: 1))
let cardBackgroundColor_7 = Color(#colorLiteral(red: 0.3254901961, green: 0.5529411765, blue: 1, alpha: 1))

let cardColorList: [Color] = [
    cardBackgroundColor_0, cardBackgroundColor_1, cardBackgroundColor_2, cardBackgroundColor_3,
    cardBackgroundColor_4, cardBackgroundColor_5, cardBackgroundColor_6, cardBackgroundColor_7
]
