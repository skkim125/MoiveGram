//
//  SimilarMovieCollectionViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/24/24.
//

import UIKit
import SnapKit

final class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    private let posterView = {
        let imgView = UIImageView()
        imgView.image = nil
        imgView.contentMode = .scaleAspectFill
        imgView.layer.borderWidth = 0.8
        imgView.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        contentView.addSubview(posterView)
    }
    
    private func configureLayout() {
        
        posterView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    func configurePosterView(data: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/original" + data)!
        
        posterView.kf.setImage(with: url)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterView.layer.cornerRadius = 8
    }
    
}
