//
//  TrendingDetailOfOverViewTableViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/12/24.
//

import UIKit
import SnapKit

class TrendingDetailOfOverViewTableViewCell: UITableViewCell {
    
    lazy var overViewLabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var extensionButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.addTarget(self, action: #selector(extensionButtonTapped), for: .touchUpInside)
        button.tintColor = .black
        
        return button
    }()
    
    var isExtension = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(overViewLabel)
        contentView.addSubview(extensionButton)
    }
    
    func configureLayout() {
        overViewLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(12)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(28)
        }
        
        extensionButton.snp.makeConstraints { make in
            make.centerX.equalTo(contentView)
            make.top.equalTo(overViewLabel.snp.bottom).offset(12)
            make.bottom.equalTo(contentView.safeAreaLayoutGuide).inset(12)
            make.size.equalTo(30)
        }
    }
 
    func configureOverviewUI(content: Content) {
        overViewLabel.text = content.overview
    }
    
    @objc func extensionButtonTapped() {
        isExtension.toggle()
        extensionButton.setImage(UIImage(systemName: isExtension ? "chevron.up" : "chevron.down"), for: .normal)
        overViewLabel.numberOfLines = isExtension ? 0 : 2

        invalidateIntrinsicContentSize()
    }
}
