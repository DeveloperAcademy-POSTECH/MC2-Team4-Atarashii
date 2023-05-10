//
//  hexStringToColor.swift
//  PocketLearner
//
//  Created by 주환 on 2023/05/10.
//

import Foundation

func hexStringToColor(hexString: String) -> Color {
    var colorString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if colorString.hasPrefix("#") {
        colorString.remove(at: colorString.startIndex)
    }
    
    if colorString.count != 6 {
        return Color.gray
    }
    
    var rgbValue: UInt64 = 0
    Scanner(string: colorString).scanHexInt64(&rgbValue)
    
    let red = Double((rgbValue & 0xFF0000) >> 16) / 255.0
    let green = Double((rgbValue & 0x00FF00) >> 8) / 255.0
    let blue = Double(rgbValue & 0x0000FF) / 255.0
    
    return Color(red: red, green: green, blue: blue)
}

