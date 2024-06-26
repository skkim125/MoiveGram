//
//  TrendingTableViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/10/24.
//

import UIKit
import SnapKit
import Kingfisher

final class TrendingTableViewCell: UITableViewCell {
    
    private let imageBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 3.0
        view.layer.shadowOpacity = 0.8
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        
        return label
    }()
    
    
    private let contentImageView: UIImageView = {
       let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.layer.cornerRadius = 12
        imgView.clipsToBounds = true
        
        return imgView
    }()
    
    private lazy var rateStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [rateInfoLabel, rateLabel])
        sv.spacing = 0
        sv.layer.shadowOpacity = 0.4
        sv.layer.cornerRadius = 12
        
        return sv
    }()
    
    private let rateInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "평점"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .darkGray
        
        return label
    }()
    
    private let rateLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.textAlignment = .center
        label.backgroundColor = .white
        
        return label
    }()
    
    private let infoLabelBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.cornerRadius = 12
        
        
        return view
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 17, weight: .medium)
        
        return label
    }()
    
    private let actorsLabel: UILabel =  {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        
        return label
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    lazy var moreStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [moreLabel, chevronImgView])
        
        return sv
    }()
    
    private let moreLabel: UILabel = {
       let label = UILabel()
        label.text = "자세히 보기"
        label.textColor = .black
        label.font = .systemFont(ofSize: 13)
        
        return label
    }()
    
    private let chevronImgView: UIImageView = {
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
    
    private func configureHierarchy() {
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
    
    private func configureLayout() {
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
    func setTableViewCellUI(content: Content, genres: [Genre], credits: Credit) {
        let contentGenre = content.genreIds.first!
        let genreArr = genres.filter { $0.id == contentGenre }
        var genreFirst = ""
        var actorsLabelText = ""
        
        if let genre = genreArr.first {
            genreFirst = genre.name
        }
        
        genreLabel.text = "#\(genreFirst)"
        rateLabel.text = String(format: "%.1f", content.rate)
        releaseDateLabel.text = content.releaseDate
        titleLabel.text = content.title
        
        
        credits.cast.forEach { cast in
            let allCast = cast.name.reduce("") { _ , name in
                actorsLabelText.append("\(name), ")
                
                actorsLabelText.removeLast()
                actorsLabelText.removeLast()
                return actorsLabelText
            }
            
            actorsLabel.text = allCast
        }
        
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (content.poster ?? ""))!
        
        contentImageView.kf.setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentImageView.image = nil
        backgroundColor = .white
    }
    
}

