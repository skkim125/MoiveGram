//
//  SimilarMovieViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/24/24.
//

import UIKit
import SnapKit

final class SimilarMovieViewController: UIViewController {
    
    private lazy var tableView = {
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
    var moviePosters: [[String]] = [[], [], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        configureHierarchy()
        configureLayout()
        requestMovie()
        
    }
    
    private func configureNavigationBar(movie: Content) {
        navigationItem.title = movie.title
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func requestMovie() {
        guard let movie = self.movie else { return }
        configureNavigationBar(movie: movie)
        
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.tmdbManager.callRequestAfTMDB(api: .similar(movie.id), type: SimilarMovies.self) {
                if let similars = $0.self {
                    self.moviePosters[0] = similars.results.map { $0.poster ?? "" }
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.tmdbManager.callRequestAfTMDB(api: .recomandation(movie.id), type: Recommendations.self) {
                if let recomandations = $0.self {
                    self.moviePosters[1] = recomandations.results.map { $0.poster ?? "" }
                }
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.tmdbManager.callRequestAfTMDB(api: .posters(movie.id), type: Posters.self) {
                if let posters = $0.self {
                    self.moviePosters[2] = posters.posters.map { $0.file ?? "" }
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
}

extension SimilarMovieViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.section == 2 ? 220 : 180
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SimilarTableHeaderView.id) as! SimilarTableHeaderView
        
        header.configureHeaderLabelUI(title: "\(SectionType.allCases[section].rawValue)")
        
        return header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SimilarMovieTableViewCell.id, for: indexPath) as! SimilarMovieTableViewCell
        cell.selectionStyle = .none
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.register(SimilarMovieCollectionViewCell.self, forCellWithReuseIdentifier: SimilarMovieCollectionViewCell.id)
        cell.collectionView.tag = indexPath.section
        cell.collectionView.reloadData()
        
        return cell
    }
}

extension SimilarMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return collectionView.tag == 2 ? CGSize(width: 150, height: 200) : CGSize(width: 120, height: 160)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviePosters[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarMovieCollectionViewCell.id, for: indexPath) as! SimilarMovieCollectionViewCell
        
        let data = moviePosters[collectionView.tag][indexPath.item]
        cell.configurePosterView(data: data)
        return cell
    }
}
