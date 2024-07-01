//
//  SearchMovieCollectionViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/11/24.
//

import UIKit

final class SearchMovieCollectionViewCell: UICollectionViewCell {
    private let imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.layer.cornerRadius = SearchMovieConstant.imgCornerRadius
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
    
    private func configureHierarchy() {
        contentView.addSubview(imgView)
    }
    
    private func configureLayout() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    /// 컬렉션뷰 셀 UI 세팅 메서드
    func configureMovieImg(data: Content) {
        if let poster = data.poster {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + (data.poster ?? ""))!
            imgView.kf.setImage(with: url)
        } else {
            self.imgView.image = UIImage(systemName: "questionmark")
            self.imgView.tintColor = .white
            self.imgView.backgroundColor = .gray
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgView.image = nil
    }
}
