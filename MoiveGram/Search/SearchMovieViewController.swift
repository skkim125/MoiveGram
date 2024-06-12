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
        
        collectionView.register(SearchMovieCollectionViewCell.self, forCellWithReuseIdentifier: SearchMovieCollectionViewCell.id)
        
        return collectionView
    }()
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width-40
        
        layout.itemSize = CGSize(width: width/3, height: width/3 + 40)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        
        return layout
    }
    
    var trendingArr: [Content] = []
    var searchResultsArr: [Content] = []
    var searchMovies: SearchMovie = SearchMovie(page: 0, results: [], total_pages: 0, total_results: 0)
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        navigationItem.title = "Search Movie"
        configureHierarchy()
        configureLayout()
        callTrendingRequest()
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
