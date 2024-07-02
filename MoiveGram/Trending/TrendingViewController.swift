//
//  TrendingViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

final class TrendingViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
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
    private var trendingArr: [Content] = []
    private var credits: [Int: Credit] = [:]
    private var videos: [Int: Videos] = [:]
    private var genreList: [Genre] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
        configureTrendingViewUI()
    }

    private func configureNavigationBar() {
        navigationItem.title = "Weekly Trend"
    }
    
    private func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureTrendingViewUI() {
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.tmdbManager.callRequestAfTMDB(api: .genre, type: GenreList.self) { genres in
                if let genres = genres {
                    self.genreList = genres.genres
                    group.leave()
                }
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.tmdbManager.callRequestAfTMDB(api: .trending, type: Trending.self) { trend in
                if let t = trend {
                    self.trendingArr = t.results
                    group.leave()
                    
                    self.trendingArr.forEach { trend in
                        group.enter()
                        DispatchQueue.global().async(group: group) {
                            self.tmdbManager.callRequestAfTMDB(api: .cast(trend.id), type: Credit.self) { credit in
                                if let credit = credit {
                                    if trend.id == credit.id {
                                        self.credits.updateValue(credit, forKey: trend.id)
                                    }
                                }
                                group.leave()
                            }
                            
                            group.enter()
                            DispatchQueue.global().async(group: group) {
                                self.tmdbManager.callRequestAfTMDB(api: .videos(trend.id), type: Videos.self) { videos in
                                    if let videoArr = videos {
                                        if trend.id == videoArr.id {
                                            self.videos.updateValue(videoArr, forKey: trend.id)
                                        }
                                    }
                                    group.leave()
                                }
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
        
        if let credit = credits[data.id] {
            cell.setTableViewCellUI(content: data, genres: genreList, credits: credit)
        }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dataIdx = indexPath.row
        let data = trendingArr[dataIdx]
        
        let vc = TrendingDetailViewController()
        vc.content = data
        vc.credits = credits[data.id]
        if let video = videos[data.id], let first = video.results.filter({ $0.site == "YouTube"}).first {
            vc.video = first
        }
        vc.configureTrendingDetailViewUI(content: data)
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
