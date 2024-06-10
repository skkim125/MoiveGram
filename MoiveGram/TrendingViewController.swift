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
    var trendingArr: [Content] = []
    
    
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureHierarchy()
        callTrendingRequest()
        configureLayout()
    }

    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
                print("\(value)\n")
                self.trendingArr = value.results
                self.tableView.reloadData()
                
            case.failure(let error):
                print("\(error)")
            }
        }
    }
}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return trendingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.id, for: indexPath) as! TrendingTableViewCell
        cell.setTableViewCellUI(content: trendingArr[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(trendingArr[indexPath.row])
    }
    
}
