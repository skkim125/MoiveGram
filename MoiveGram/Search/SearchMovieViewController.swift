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
    
    var trendingArr: [Content] = []
    var searchResultsArr: [Content] = []
    var searchMovies: SearchMovie = SearchMovie(page: 0, results: [], total_pages: 0, total_results: 0)
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureHierarchy()
        configureLayout()
        callTrendingRequest()
    }
    
    func configureView() {
        view.backgroundColor = .black

        navigationItem.title = "Search Movie"
    }
    func configureHierarchy() {
        // MARK: addSubView()
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
    
    /// Trending 영화 불러오기
    func callTrendingRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/week"
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Trending.self) { response in
            switch response.result {
            case .success(let value):
                for i in 0...5 {
                    self.trendingArr.append(value.results[i])
                }
                self.collectionView.reloadData()
                
            case.failure(let error):
                print("\(error)")
            }
        }
    }
    
    /// 검색 결과 불러오기
    func callSearchResultRequest(keyword: String) {
        let url = "https://api.themoviedb.org/3/search/movie"
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
        ]
        let paramters: Parameters = [
            "query": keyword,
            "page": currentPage
        ]
        
        AF.request(url, method: .get, parameters: paramters, headers: header).responseDecodable(of: SearchMovie.self) { response in
            switch response.result {
            case .success(let value):
                self.searchMovies = value
                print("value.total_pages", value.total_pages)
                print("value.total_results", value.total_results)
                
                if value.total_results == 0 {
                    self.searchBar.text = nil
                    self.searchBar.placeholder = "No Result"
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
                
            case.failure(let error):
                print("\(error)")
            }
        }
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
    
}

extension SearchMovieViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for item in indexPaths {
            if searchResultsArr.count-2 == item.item && searchMovies.page != searchMovies.total_pages {
                currentPage += 1
                callSearchResultRequest(keyword: searchBar.text!)
            }
        }
    }
    
}

// MARK: - UISearchBar extension
extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResultsArr.removeAll()
        if let text = searchBar.text {
            callSearchResultRequest(keyword: text)
            if text.trimmingCharacters(in: .whitespaces).isEmpty {
                searchBar.placeholder = "Please enter at least one character"
            } else {
                currentPage = 1
            }
        }
    }
}
