//
//  SearchMovieCollectionViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/11/24.
//

import UIKit

class SearchMovieCollectionViewCell: UICollectionViewCell {
    lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.layer.cornerRadius = 12
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(imgView)
    }
    
    func configureLayout() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureMovieImg(data: Content) {
        if let image = data.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + image)!
            imgView.kf.setImage(with: url)
        } else {
            imgView.image = UIImage(systemName: "questionmark")
            imgView.tintColor = .white
            imgView.backgroundColor = .gray
        }
    }
}
