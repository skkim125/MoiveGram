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
    
    func configureHierarchy() {
        contentView.addSubview(imgView)
    }
    
    func configureLayout() {
        imgView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    /// 컬렉션뷰 셀 UI 세팅 메서드
    func configureMovieImg(data: Content) {
        let url = URL(string: "https://image.tmdb.org/t/p/original" + (data.poster ?? ""))!
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(data: data)
                }
            } catch {
                DispatchQueue.main.async {
                    self.imgView.image = UIImage(systemName: "questionmark")
                    self.imgView.tintColor = .white
                    self.imgView.backgroundColor = .gray
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgView.image = nil
    }
}
