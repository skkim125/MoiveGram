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
    
    private let tmdbManager = TMDBManager.shared
    var trendingArr: [Content] = []
    var genreList: [Genre] = []
    var credits: [Credit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configureTrendingViewUI()
    }

    func configureNavigationBar() {
        navigationItem.title = "Weekly Trend"
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureTrendingViewUI() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.tmdbManager.callRequestTMDB(api: .genre, type: GenreList.self) { genres in
                if let genres = genres {
                    self.genreList = genres.genres
                    group.leave()
                }
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.tmdbManager.callRequestTMDB(api: .trending, type: Trending.self) { trend in
                if let trend = trend {
                    self.trendingArr = trend.results
                    group.leave()
                    
                    self.trendingArr.forEach { trend in
                        group.enter()
                        DispatchQueue.global().async(group: group) {
                            self.tmdbManager.callRequestTMDB(api: .cast(trend.id), type: Credit.self) { credit in
                                if let credit = credit {
                                    self.credits.append(credit)
                                }
                                group.leave()
                            }
                        }
                    }
                }
                group.notify(queue: .main) {
                    self.tableView.reloadData()
                }
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
