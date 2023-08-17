//
//  Assets.swift
//  PocketLearner
//
//  Created by 황지우2 on 2023/08/17.
//

import SwiftUI

// Image Asset
extension Image {
    enum imageAssetName: String {
        case mainCharacter
    }
    init(_ imageName: imageAssetName){
        self.init(imageName.rawValue)
    }
}
