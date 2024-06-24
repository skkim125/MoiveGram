//
//  TrendingDetailTableViewCell.swift
//  MoiveGram
//
//  Created by 김상규 on 6/12/24.
//

import UIKit
import SnapKit

class TrendingDetailOfCreditTableViewCell: UITableViewCell {
    
    lazy var castImageView = {
       let imgView = UIImageView()
        imgView.layer.cornerRadius = 5
        imgView.backgroundColor = .lightGray
        imgView.tintColor = .white
        
        return imgView
    }()
    
    lazy var castNameLabel = {
        let label = UILabel()
        
        return label
    }()
    
    lazy var movieCharacterLabel = {
        let label = UILabel()
        label.textColor = .lightGray
        
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        // MARK: addSubView()
        contentView.addSubview(castImageView)
        contentView.addSubview(castNameLabel)
        contentView.addSubview(movieCharacterLabel)
    }
    
    func configureLayout() {
        castImageView.snp.makeConstraints { make in
            make.verticalEdges.equalTo(contentView.safeAreaLayoutGuide).inset(10)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(castImageView.snp.height).multipliedBy(0.7)
        }
        
        castNameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(20)
            make.leading.equalTo(castImageView.snp.trailing).offset(15)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(10)
        }
        
        movieCharacterLabel.snp.makeConstraints { make in
            make.top.equalTo(castNameLabel.snp.bottom).offset(10)
            make.leading.equalTo(castNameLabel)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configureCastCellUI(cast: Cast) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (cast.profile_path ?? ""))!
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.castImageView.image = UIImage(data: data)
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.castImageView.image = UIImage(systemName: "person.fill")
                }
            }
        }
        castNameLabel.text = cast.name
        movieCharacterLabel.text = cast.character ?? ""
    }
    
    func configureCrewCellUI(crew: Crew) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500" + (crew.profile_path ?? ""))!
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    self.castImageView.image = UIImage(data: data)
                    self.castImageView.contentMode = .scaleAspectFit
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.castImageView.image = UIImage(systemName: "camera.fill")
                    self.castImageView.contentMode = .scaleAspectFit
                }
            }
        }
        castNameLabel.text = crew.name
        movieCharacterLabel.text = crew.department ?? ""
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        castImageView.image = nil
        castNameLabel.text = nil
        movieCharacterLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        castImageView.clipsToBounds = true
    }
}
