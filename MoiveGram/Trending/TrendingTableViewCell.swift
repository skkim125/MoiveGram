//
//  TrendingTableViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

class TrendingTableViewCell: UITableViewCell {
    
    lazy var imageBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.shadowRadius = 5.0
        view.layer.shadowOpacity = 0.4
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    
    lazy var contentImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.layer.cornerRadius = 12
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    lazy var rateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [rateInfoLabel, rateLabel])
        sv.spacing = 0
        sv.layer.shadowOpacity = 0.4
        sv.layer.cornerRadius = 12
        
        return sv
    }()
    
    lazy var rateInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        
        return label
    }()
    
    lazy var rateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        
        return label
    }()
    
    lazy var infoLabelBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 12
        
        
        return view
    }()
    
    lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    
    lazy var actorsLabel: UILabel =  {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    lazy var moreStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [moreLabel, chevronImgView])
        
        return sv
    }()
    
    lazy var moreLabel: UILabel = {
       let label = UILabel()
        label.text = "자세히 보기"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    
    lazy var chevronImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(systemName: "chevron.right")
        imgView.tintColor = .darkGray
        imgView.contentMode = .scaleAspectFit
        
        
        return imgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    func configureHierarchy() {
        contentView.addSubview(releaseDateLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(imageBackView)
        contentView.addSubview(contentImageView)
        contentView.addSubview(infoLabelBackView)
        contentView.addSubview(rateStackView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(actorsLabel)
        contentView.addSubview(dividerView)
        contentView.addSubview(moreStackView)
    }
    
    func configureLayout() {
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom)
            make.leading.equalTo(releaseDateLabel.snp.leading)
        }
        
        imageBackView.snp.makeConstraints { make in
            make.top.equalTo(genreLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(imageBackView.snp.width)
            make.bottom.equalTo(contentView.snp.bottom).inset(12)
        }
        
        contentImageView.snp.makeConstraints { make in
            make.edges.equalTo(imageBackView)
            make.size.equalTo(imageBackView)
        }
        
        rateStackView.snp.makeConstraints { make in
            make.leading.equalTo(contentImageView.snp.leading).offset(12)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
        
        infoLabelBackView.snp.makeConstraints { make in
            make.top.equalTo(rateStackView.snp.bottom).offset(12)
            make.bottom.equalTo(contentImageView.snp.bottom)
            make.horizontalEdges.equalTo(contentImageView.snp.horizontalEdges)
            make.width.equalTo(contentImageView.snp.width)
            make.height.equalTo(110)
        }
        
        rateInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(rateStackView.snp.leading)
            make.width.equalTo(30)
            make.height.equalTo(rateStackView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoLabelBackView.snp.top).offset(12)
            make.horizontalEdges.equalTo(infoLabelBackView.snp.horizontalEdges).inset(16)
        }
        
        actorsLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(titleLabel.snp.horizontalEdges)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(actorsLabel.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(actorsLabel.snp.horizontalEdges)
            make.height.equalTo(1)
        }
        
        moreStackView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(12)
            make.horizontalEdges.equalTo(dividerView)
            make.bottom.equalTo(infoLabelBackView.snp.bottom).inset(8)
            make.height.equalTo(24)
        }
        
        chevronImgView.snp.makeConstraints { make in
            make.trailing.equalTo(moreStackView.snp.trailing).inset(4)
            make.width.equalTo(moreStackView.snp.height)
        }
        
        moreLabel.snp.makeConstraints { make in
            make.leading.equalTo(moreStackView.snp.leading).offset(4)
            make.trailing.equalTo(chevronImgView.snp.leading)
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 테이블뷰 셀 UI 세팅
    func setTableViewCellUI(content: Content, genres: [Genre], credits: [Credit]) {
        let contentGenre = content.genre_ids.first!
        let genreArr = genres.filter { $0.id == contentGenre }
        var genreFirst = ""
        var actorsLabelText = ""
        
        if let genre = genreArr.first {
            genreFirst = genre.name
        }
        
        genreLabel.text = "#\(genreFirst)"
        rateLabel.text = String(format: "%.1f", content.vote_average)
        releaseDateLabel.text = content.release_date
        titleLabel.text = content.title
        
        let filterdArr = credits.filter { $0.id == content.id }
        
        filterdArr.forEach { credit in
            let allCast = credit.cast.reduce("") { _ , cast in
                actorsLabelText.append("\(cast.name), ")
                
                if cast.name == credit.cast.last!.name {
                    actorsLabelText.removeLast()
                    actorsLabelText.removeLast()
                }
                return actorsLabelText
            }
            
            actorsLabel.text = allCast
        }
        
        let url = URL(string: "https://image.tmdb.org/t/p/original" + (content.poster_path ?? ""))!
        contentImageView.kf.setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = .white
    }
    
}

