//
//  CardTemplate.swift
//  bletest
//
//  Created by Ye Eun Choi on 2023/05/08.
//

import SwiftUI

struct CardTemplate: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    // MARK: - 편집 기능이 담긴 More Action 아이콘
                    Image(systemName: "ellipsis")
                        .contextMenu {
                            Button {
                                // MARK: - 카드 커스텀 뷰로 이동
                                EditCardDesignView()
                            } label: {
                                Label("카드 커스텀", systemImage: "paintpalette")
                            }
                            Button {
                                // MARK: - 카드 내용 수정 뷰로 이동
                                EditCardInfoView()
                            } label: {
                                Label("명함 내용 수정", systemImage: "pencil")
                            }
                        }
                }
                
                // MARK: - 국문 닉네임
                Text("리앤")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .padding(.top, 80)
                
                // MARK: - 영문 닉네임
                Text("Lianne")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
                    .padding(.bottom, 12)
               
                // MARK: - 자기 소개
                Text("다재다능한 디발자가 꿈⭐️🐠🐶 개자이너 아니고 디발자요!")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.system(size: 20))
            }
            .padding(22)
            
            
            
            Spacer()
            
            HStack {
                // MARK: - 오전/오후 세션 태그
                /// TODO: 세션 태그 컴포넌트로 변경
                Text("오후")
                Spacer()
                // MARK: - 미모지 아바타 이미지
                /// TODO: API 연결
                Circle()
                    .frame(width: 100)
            }
            .padding(22)
            
        }
        .frame(height: 490)
        /// TODO: 컬러 extension 추가 후 적용
        .background(Color.purple)
        .cornerRadius(32)
    }
}


struct CardTemplate_Previews: PreviewProvider {
    static var previews: some View {
        CardTemplate()
    }
}
