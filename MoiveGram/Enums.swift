//
//  Enums.swift
//  MoiveGram
//
//  Created by 김상규 on 6/12/24.
//

import Foundation

enum LoginViewTFConstant {
    enum placeholder: String {
        case id = "이메일 주소 또는 전화번호"
        case password = "비밀번호"
        case nickname = "닉네임"
        case country = "국가"
        case recommandCode = "추천코드"
    }
}

enum SearchMovieConstant {
    static let imgCornerRadius: CGFloat = 12
}

enum SectionType: String, CaseIterable {
    case similar = "비슷한 영화"
    case recomandation = "추천 영화"
    case poster = "포스터"
}
