//
//  SimilarMovieCollectionViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/24/24.
//

import UIKit
import SnapKit

class SimilarMovieCollectionViewCell: UICollectionViewCell {
    
    lazy var posterView = {
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
    
    func configureHierarchy() {
        contentView.addSubview(posterView)
    }
    
    func configureLayout() {
        
        posterView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    func configurePosterView(data: String) {
        let url = URL(string: "https://image.tmdb.org/t/p/original" + data)!
        
        //        posterView.kf.setImage(with: url)
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.posterView.image = image
                }
            } catch {
                DispatchQueue.main.async {
                    self.posterView.image = UIImage(systemName: "photo.artframe")
                    self.posterView.contentMode = .scaleAspectFit
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        posterView.layer.cornerRadius = 8
    }
    
}
