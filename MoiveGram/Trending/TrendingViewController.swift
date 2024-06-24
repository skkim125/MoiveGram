//
//  TrendingViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

class TrendingViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        return tableView
    }()
    
    var trendingArr: [Content] = []
    var genreList: [Genre] = []
    var credits: [Credit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureHierarchy()
        callTrendingRequest()
        configureLayout()
        callGenreRequest()
    }

    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - Methods
extension TrendingViewController {
    /// 이주의 Trending 영화 불러오기 + 장르리스트 & 캐스팅 메서드 호출
    func callTrendingRequest() {
        let url = "https://api.themoviedb.org/3/trending/movie/week"
        let header: HTTPHeaders = [
            "Authorization": APIKey.tmdbKey,
            "accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: header).responseDecodable(of: Trending.self) { response in
            switch response.result {
            case .success(let value):
                self.trendingArr = value.results
                self.callGenreRequest()
                for i in self.trendingArr {
                    self.callCastRequest(id: i.id)
                }
                //self.tableView.reloadData()
            case.failure(let error):
                print("\(error)")
            }
        }
        
    }
    
    /// 영화 장르 리스트 불러오기
    func callGenreRequest() {
        let url = "https://api.themoviedb.org/3/genre/movie/list?language=en"
        let headers: HTTPHeaders = [
                "Authorization": APIKey.tmdbKey,
                "accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: GenreList.self) { response in
            switch response.result {
            case .success(let value):
                self.genreList = value.genres
            case.failure(let error):
                print("\(error)")
            }
        }
    }
    
    /// 영화 캐스팅 불러오기
    func callCastRequest(id: Int) {
        let url = "https://api.themoviedb.org/3/movie/\(id)/credits?language=kr-Ko"
        let headers: HTTPHeaders = [
                "Authorization": APIKey.tmdbKey,
                "accept": "application/json"
        ]
        
        AF.request(url, method: .get, headers: headers).responseDecodable(of: Credit.self) { response in
            switch response.result {
            case .success(let value):
                self.credits.append(value)
                self.tableView.reloadData()
            case.failure(let error):
                print("\(error)")
            }
        }
    }
}

// MARK: - UITableView extension
extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return trendingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.id, for: indexPath) as! TrendingTableViewCell
        let dataidx = indexPath.row
        let data = trendingArr[dataidx]
        
        cell.setTableViewCellUI(content: data, genres: genreList, credits: credits)
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataIdx = indexPath.row
        let data = trendingArr[dataIdx]
        
        let vc = TrendingDetailViewController()
        vc.content = data
        vc.credits = credits[indexPath.row]
        vc.configureTrendingDetailViewUI(content: data)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
