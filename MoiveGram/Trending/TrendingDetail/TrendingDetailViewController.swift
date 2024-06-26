//
//  TrendingDetailViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/12/24.
//

import UIKit
import Kingfisher
import SnapKit

final class TrendingDetailViewController: UIViewController {
    
    private let movieBGImageView = {
       let imgView = UIImageView()
        
        return imgView
    }()
    
    private let movieTitleBG = {
       let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.5)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        
        return view
    }()
    
    private let movieTitleLabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .heavy)
        label.textColor = .white
        label.clipsToBounds = true
        
        return label
    }()
    
    private let moviePosterImageView = {
       let imgView = UIImageView()
        imgView.backgroundColor = .white
        imgView.layer.shadowOffset = .zero
        imgView.layer.shadowRadius = 3
        imgView.layer.shadowOpacity = 1
        imgView.layer.borderWidth = 0.8
        imgView.layer.borderColor = UIColor.white.withAlphaComponent(0.8).cgColor
        
        return imgView
    }()
    
    private lazy var tableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(TrendingDetailOfOverViewTableViewCell.self, forCellReuseIdentifier: TrendingDetailOfOverViewTableViewCell.id)
        tv.register(TrendingDetailOfCreditTableViewCell.self, forCellReuseIdentifier: TrendingDetailOfCreditTableViewCell.id)
        tv.isUserInteractionEnabled = true
        
        return tv
    }()
    
    var content: Content?
    var credits: Credit?
    var video: Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureNavigationBar() {
        navigationItem.title = "출연/제작"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "play.rectangle.fill"), style: .plain, target: self, action: #selector(goTrailerPlayer))
    }
    
    @objc func goTrailerPlayer() {
        guard let video = self.video else {
            let alert = UIAlertController(title: "제공되는 영상이 없습니다.", message: nil, preferredStyle: .alert)
            let cancel = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(cancel)
            
            present(alert, animated: true)
            
            return
        }
        
        let vc = TrendingTrailerWebView()
        vc.configureWebView(link: video.link)
        
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        
        present(nav, animated: true)
    }

    private func configureHierarchy() {
        view.addSubview(movieBGImageView)
        view.addSubview(movieTitleBG)
        movieTitleBG.addSubview(movieTitleLabel)
        view.addSubview(moviePosterImageView)
        view.addSubview(tableView)
    }
    
    private func configureLayout() {
        movieBGImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(240)
        }
        
        movieTitleBG.snp.makeConstraints { make in
            make.top.equalTo(movieBGImageView.snp.top).inset(24)
            make.leading.equalTo(movieBGImageView.snp.leading).inset(20)
            make.trailing.lessThanOrEqualTo(movieBGImageView.snp.trailing).inset(20)
            make.height.equalTo(40)
        }
        
        movieTitleLabel.snp.makeConstraints { make in
            make.edges.equalTo(movieTitleBG.snp.edges).inset(5)
        }
        
        moviePosterImageView.snp.makeConstraints { make in
            make.top.equalTo(movieTitleBG.snp.bottom).offset(8)
            make.leading.equalTo(movieTitleBG.snp.leading).offset(4)
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
        let bgUrl = URL(string: "https://image.tmdb.org/t/p/original" + (content.background ?? ""))!
        let posterUrl = URL(string: "https://image.tmdb.org/t/p/original" + (content.poster ?? ""))!
        movieBGImageView.kf.setImage(with: bgUrl)
        moviePosterImageView.kf.setImage(with: posterUrl)
        movieTitleLabel.text = content.title
    }
}

extension TrendingDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let credit = credits {
            if section == 1 {
                return credit.cast.count
            } else if section == 2 {
                return credit.crew.count
            }
        }
        return 1
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
            
            if let c = credits {
                let data = c.cast[indexPath.row]
                cell.configureCastCellUI(cast: data)
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingDetailOfCreditTableViewCell.id, for: indexPath) as! TrendingDetailOfCreditTableViewCell
            cell.selectionStyle = .none
            
            if let c = credits {
                let data = c.crew[indexPath.row]
                cell.configureCrewCellUI(crew: data)
            }
            
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
