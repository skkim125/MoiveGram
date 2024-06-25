//
//  CustomViews.swift
//  MoiveGram
//
//  Created by 김상규 on 6/12/24.
//

import UIKit
import SnapKit

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

class SimilarTableHeaderView: UITableViewHeaderFooterView {
    
    lazy var sectionLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        
        DispatchQueue.main.async {
            let attributedString = NSMutableAttributedString(string: label.text ?? "")
            attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: ((label.text ?? "") as NSString).range(of: label.text ?? ""))
            
            label.attributedText = attributedString
        }
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(sectionLabel)
    }
    
    func configureLayout() {
        sectionLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(15)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(5)
        }
    }
    
    func configureHeaderLabelUI(title: String) {
        sectionLabel.text = title
    }
    
}
