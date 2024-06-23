//
//  CustomViews.swift
//  MoiveGram
//
//  Created by 김상규 on 6/12/24.
//

import UIKit

class LoginViewTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTF(placeholder: String) {
        // NSAttributedString: 문자열에 관련된 속성(폰트, 문자 사이의 간격 등등)을 커스텀할 때 사용
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.white])
        textColor = .white
        textAlignment = .center
        layer.cornerRadius = 8
        backgroundColor = .lightGray
    }
}
