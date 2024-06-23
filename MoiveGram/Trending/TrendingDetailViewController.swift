//
//  TrendingDetailViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/12/24.
//

import UIKit
import Kingfisher
import SnapKit

class TrendingDetailViewController: UIViewController {
    
    lazy var movieBGImageView = {
       let imgView = UIImageView()
        
        return imgView
    }()
    
    lazy var movieTitleLabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .white
        label.clipsToBounds = true
        
        return label
    }()
    
    lazy var moviePosterImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.layer.shadowOffset = .zero
        imgView.layer.shadowRadius = 3
        imgView.layer.shadowOpacity = 1
        
        return imgView
    }()
    
    lazy var tableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(TrendingDetailOfOverViewTableViewCell.self, forCellReuseIdentifier: TrendingDetailOfOverViewTableViewCell.id)
        tv.register(TrendingDetailOfCreditTableViewCell.self, forCellReuseIdentifier: TrendingDetailOfCreditTableViewCell.id)
        tv.isUserInteractionEnabled = true
        tv.rowHeight = UITableView.automaticDimension
        tv.estimatedRowHeight = UITableView.automaticDimension
        
        return tv
    }()
    
    var content: Content?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.title = "출연/제작"
        
        configureHierarchy()
        configureLayout()
    }

    func configureHierarchy() {
        view.addSubview(movieBGImageView)
        view.addSubview(movieTitleLabel)
        view.addSubview(moviePosterImageView)
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        movieBGImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieBGImageView.snp.top).inset(24)
            make.horizontalEdges.equalTo(movieBGImageView.snp.horizontalEdges).inset(20)
            make.height.equalTo(40)
        }
        
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(8)
            make.leading.equalTo(movieTitleLabel.snp.leading).offset(4)
            make.bottom.equalTo(movieBGImageView.snp.bottom).inset(8)
            make.width.equalTo(120)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(movieBGImageView.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureTrendingDetailViewUI(content: Content) {
        let bgUrl = URL(string: "https://image.tmdb.org/t/p/original" + (content.poster_path ?? ""))!
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/original" + (content.poster_path ?? ""))!
        movieBGImageView.kf.setImage(with: bgUrl)
        movieTitleLabel.text = content.title
        moviePosterImageView.kf.setImage(with: posterUrl)
    }
}

extension TrendingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else if section == 1 {
            return 5
        }
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOfOverViewTableViewCell.id, for: indexPath) as! TrendingDetailOfOverViewTableViewCell
            cell.selectionStyle = .none
            
            if let c = content {
                cell.configureOverviewUI(content: c)
            }
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOfCreditTableViewCell.id, for: indexPath) as! TrendingDetailOfCreditTableViewCell
            cell.selectionStyle = .none
            
            if let c = content {
                cell.configureCellUI(content: c)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOfCreditTableViewCell.id, for: indexPath) as! TrendingDetailOfCreditTableViewCell
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "OverView"
        } else if section == 1 {
            return "Cast"
        }
        
        return "Crew"
    }
    
}
