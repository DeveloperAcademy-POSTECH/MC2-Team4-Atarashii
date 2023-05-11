//
//  ConvertedMemojiView.swift
//  PocketLearner
//
//  Created by Ye Eun Choi on 2023/05/12.
//

import SwiftUI

// MARK: - MemojiView SwiftUI에서 사용하기
/// UIViewRepresentable: UIKit view를 SwiftUI에서 사용할 수 있도록 wrapping 해주는 프로토콜
struct ConvertedMemojiView: UIViewRepresentable {
    
    // MARK: - makeUIView(context:) -> UIView
    /// UIView 생성 및 초기화
    /// 생성한 UIView를 SwiftUI의 View로 래핑
    func makeUIView(context: Context) -> UIView {
        let memojiView = MemojiView(frame: .zero)
        memojiView.tintColor = .white
        return memojiView
    }
    
    // MARK: - updateUIView(:context:)
    /// view의 정보를 업데이트
    /// SwiftUI View의 state가 바뀔 때마다 트리거
    /// @Binding을 통해 SwiftUI View의 상태를 read-only로 가져올 수 있음
    func updateUIView(_ uiView: UIView, context: Context) {
        let memojiView = MemojiView(frame: .zero)
        memojiView.onChange = { image, imageType in
//            uiImage = image
        }
    }
}

struct ConvertedMemojiView_Previews: PreviewProvider {
    static var previews: some View {
        ConvertedMemojiView()
    }
}
