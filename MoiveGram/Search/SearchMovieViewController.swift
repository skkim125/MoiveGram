//
//  SearchMovieViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/11/24.
//

import UIKit
import Alamofire
import Kingfisher
import SnapKit

class SearchMovieViewController: UIViewController {
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        searchBar.searchTextField.backgroundColor = .darkGray
        searchBar.searchTextField.textColor = .white
        
        return searchBar
    }()
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        collectionView.backgroundColor = .black
        
        collectionView.register(SearchMovieCollectionViewCell.self, forCellWithReuseIdentifier: SearchMovieCollectionViewCell.id)
        
        return collectionView
    }()
    
    private let tmdbManager = TMDBManager.shared
    var trendingArr: [Content] = []
    var searchResultsArr: [Content] = []
    var searchMovies: SearchMovie = SearchMovie(page: 0, results: [], totalPages: 0, totalResults: 0)
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        getTrending()
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationItem.title = "Search Movie"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func getTrending() {
        tmdbManager.callTrendingRequest(api: .trending) { results in
            self.trendingArr.append(contentsOf: results[0...5])
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Methods
extension SearchMovieViewController {
    
    /// 컬렉션뷰 셀 레이아웃
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 12
        let cellSpacing: CGFloat = 12
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2 + cellSpacing * 2)
        
        layout.itemSize = CGSize(width: width/3, height: width/3 * 1.5)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = .init(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}

// MARK: - CollectionView extension
extension SearchMovieViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResultsArr.isEmpty ? trendingArr.count : searchResultsArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMovieCollectionViewCell.id, for: indexPath) as! SearchMovieCollectionViewCell
        
        guard searchResultsArr.isEmpty else {
            let data = searchResultsArr[indexPath.row]
            cell.configureMovieImg(data: data)
            return cell
        }
        
        let data = trendingArr[indexPath.row]
        cell.configureMovieImg(data: data)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let data = searchResultsArr.isEmpty ? trendingArr[indexPath.item] : searchResultsArr[indexPath.item]
        
        let vc = SimilarMovieViewController()
        vc.movie = data
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension SearchMovieViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if searchResultsArr.count-2 == indexPath.row && searchMovies.page < searchMovies.totalPages {
                currentPage += 1
                tmdbManager.callSearchResultRequest(api: .search(searchBar.text!, currentPage)) { movie in
                    self.searchMovies = movie
                    self.movieSearchLogic(movie: movie)
                }
            }
        }
    }
    
}


// MARK: - UISearchBar extension
extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResultsArr.removeAll()
        if let text = searchBar.text {
            tmdbManager.callSearchResultRequest(api: .search(text, currentPage)) { movie in
                self.searchMovies = movie
                self.movieSearchLogic(movie: movie)
            }
            if text.trimmingCharacters(in: .whitespaces).isEmpty {
                searchBar.placeholder = "Please enter at least one character"
                collectionView.reloadData()
            } else {
                currentPage = 1
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchResultsArr.removeAll()
        collectionView.reloadData()
    }
    
    func movieSearchLogic(movie: SearchMovie) {
        if movie.totalResults == 0 {
            self.searchBar.text = nil
            self.searchBar.placeholder = "No Result"
            collectionView.reloadData()
            
            return
        }
        
        if self.currentPage == 1 {
            self.searchResultsArr = self.searchMovies.results
        } else {
            self.searchResultsArr.append(contentsOf: self.searchMovies.results)
        }
        
        self.collectionView.reloadData()
        if self.currentPage == 1 {
            self.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
    }
}
