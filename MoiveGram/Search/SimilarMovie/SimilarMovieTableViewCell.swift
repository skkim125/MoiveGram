//
//  SimilarMovieTableViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/24/24.
//

import UIKit
import SnapKit

class SimilarMovieTableViewCell: UITableViewCell {
    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        cv.delegate = self
        cv.dataSource = self
        cv.register(SimilarMovieCollectionViewCell.self, forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.id)
        cv.showsHorizontalScrollIndicator = false
        
        return cv
    }()
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let cellSpacing: CGFloat = 5
        let sectionSpacing: CGFloat = 5
        let width = UIScreen.main.bounds.width - (sectionSpacing*2 + cellSpacing)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width/2 * 0.8, height: width/2 * 1.1)
        
        return layout
    }
    
    var similarMovies: [SimilarMovie] = []
    var recommendations: [Recommendation] = []
    var posters: [Poster] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
}

extension SimilarMovieTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        switch indexPath.section {
//        case 0:
//            return CGSize(width: 100, height: 180)
//        case 1:
//            return CGSize(width: 100, height: 180)
//        case 2:
//            return CGSize(width: 160, height: 220)
//        default:
//            return CGSize()
//        }
//    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return similarMovies.count
        case 1:
            return recommendations.count
        case 2:
            return posters.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.id, for: indexPath) as! SimilarMovieCollectionViewCell
        cell.backgroundColor = .black
        switch indexPath.section {
        case 0:
            if let poster = similarMovies[indexPath.item].poster_path {
                DispatchQueue.main.async {
                    cell.configurePosterView(data: poster)
                }
            }
            return cell
        case 1:
            if let poster = recommendations[indexPath.item].poster_path {
                DispatchQueue.main.async {
                    cell.configurePosterView(data: poster)
                }
            }
            return cell
        case 2:
            if let poster = posters[indexPath.item].file_path {
                DispatchQueue.main.async {
                    cell.configurePosterView(data: poster)
                }
            }
            return cell
        default:
            return cell
        }
    }
}
