//
//  SimilarMovieViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/24/24.
//

import UIKit
import SnapKit

class SimilarMovieViewController: UIViewController {
    
    lazy var tableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SimilarMovieTableViewCell.self, forCellReuseIdentifier: SimilarMovieTableViewCell.id)
        tv.register(SimilarTableHeaderView.self, forHeaderFooterViewReuseIdentifier: SimilarTableHeaderView.id)
        tv.separatorStyle = .none
        tv.backgroundColor = .black
        tv.showsVerticalScrollIndicator = false
        
        return tv
    }()
    
    private let tmdbManager = TMDBManager.shared
    var movie: Content?
    var similarMovies: [SimilarMovie] = []
    var recommendations: [Recommendation] = []
    var posters: [Poster] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        configureHierarchy()
        configureLayout()
        requestSimilar()
        
    }
    
    func configureNavigationBar(movie: Content) {
        navigationItem.title = movie.original_title
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func requestSimilar() {
        if let movie = self.movie {
            configureNavigationBar(movie: movie)
            tmdbManager.requestSimilarMovies(movieID: movie.id) { data in
                DispatchQueue.global().async {
                    self.similarMovies = data.results
                }
                self.tableView.reloadData()
            }
            
            tmdbManager.requestRecomendations(movieID: movie.id) { data in
                DispatchQueue.global().async {
                    self.recommendations = data.results
                }
                self.tableView.reloadData()
            }
            
            tmdbManager.requestPosters(movieID: movie.id) { data in
                DispatchQueue.global().async {
                    self.posters = data.posters
                }
                self.tableView.reloadData()
            }
        }
    }
}

extension SimilarMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 2 {
            return 180
        }
        
        return 220
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SimilarTableHeaderView.id) as! SimilarTableHeaderView
        
        header.configureHeaderLabelUI(title: "\(SectionType.allCases[section])")
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimilarMovieTableViewCell.id, for: indexPath) as! SimilarMovieTableViewCell
         
        switch indexPath.section {
        case 0:
            cell.similarMovies = similarMovies
            cell.collectionView.reloadData()
            return cell
        case 1:
            cell.recommendations = recommendations
            cell.collectionView.reloadData()
            return cell
        case 2:
            cell.posters = posters
            cell.collectionView.reloadData()
            return cell
            
        default:
            return cell
        }
        
    }
    
}

enum SectionType: String, CaseIterable {
    case similar = "비슷한 영화"
    case recomandation = "추천 영화"
    case poster = "포스터"
}
