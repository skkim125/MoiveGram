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
        imgView.backgroundColor = .gray
        
        return imgView
    }()
    
    lazy var movieTitleLabel = {
       let label = UILabel()
        label.backgroundColor = .cyan
        
        return label
    }()
    
    lazy var moviePosterImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = .white
        
        return imgView
    }()
    
    lazy var tableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(TrendingDetailOfOverViewTableViewCell.self, forCellReuseIdentifier: TrendingDetailOfOverViewTableViewCell.id)
        tv.register(TrendingDetailOfCreditTableViewCell.self, forCellReuseIdentifier: TrendingDetailOfCreditTableViewCell.id)
        tv.rowHeight = UITableView.automaticDimension
        
        return tv
    }()
    
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
            make.leading.equalTo(movieBGImageView.snp.leading).offset(20)
            make.width.equalTo(280)
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
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOfOverViewTableViewCell.id, for: indexPath)
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOfCreditTableViewCell.id, for: indexPath) as! TrendingDetailOfCreditTableViewCell
        
        return cell
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
