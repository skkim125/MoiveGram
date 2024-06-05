//
//  HomeViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/4/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "극한직업")
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let subImageView1: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "명량")
        view.backgroundColor = .blue
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let subImageView2: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "도둑들")
        view.backgroundColor = .black
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let subImageView3: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "베테랑")
        view.backgroundColor = .red
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        
        return view
    }()
    
    let nowHotContentsLabel: UILabel = {
        let view = UILabel()
        view.layer.cornerRadius = 8
        view.text = "지금 뜨는 콘텐츠"
        view.font = .systemFont(ofSize: 16)
        view.textColor = .white
        
        return view
    }()
    
    let watchButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.setTitle("재생", for: .normal)
        view.setImage(UIImage(systemName: "play.fill"), for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.setTitleColor(.black, for: .normal)
        
        
        return view
    }()
    
    let saveButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 8
        
        view.setTitle("내가 찜한 리스트", for: .normal)
        view.setImage(UIImage(systemName: "plus"), for: .normal)
        view.imageView?.contentMode = .scaleAspectFit
        view.setTitleColor(.white, for: .normal)
        
        return view
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        navigationItem.title = "Harvey님"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        
        configureHierarchy()
        configureLayout()
    }

    
    
    func configureHierarchy() {
        let viewArray = [mainImageView, subImageView1, subImageView2, subImageView3, nowHotContentsLabel, watchButton, saveButton]
        
        for item in viewArray {
            view.addSubview(item)
        }
    }
    
    func configureLayout() {
        mainImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nowHotContentsLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(8)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(12)
            make.height.equalTo(32)
        }
        
        subImageView1.snp.makeConstraints { make in
            make.top.equalTo(nowHotContentsLabel.snp.bottom).offset(8) //
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20) //
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8) //
            make.height.equalTo(180)
        }
        
        subImageView2.snp.makeConstraints { make in
            make.centerX.equalTo(mainImageView.snp.centerX)
            make.top.equalTo(nowHotContentsLabel.snp.bottom).offset(8) //
            make.leading.equalTo(subImageView1.snp.trailing).offset(8)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8) //
            make.width.equalTo(subImageView1.snp.width)
            make.height.equalTo(subImageView1)
        }
        
        subImageView3.snp.makeConstraints { make in
            make.top.equalTo(nowHotContentsLabel.snp.bottom).offset(8)
            make.leading.equalTo(subImageView2.snp.trailing).offset(8)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(8) //
        }
        
        watchButton.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.bottom).inset(12)
            make.leading.equalTo(mainImageView.snp.leading).inset(12)
            make.height.equalTo(44)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.bottom).inset(12)
            make.leading.equalTo(watchButton.snp.trailing).offset(12)
            make.trailing.equalTo(mainImageView.snp.trailing).inset(12)
            make.height.equalTo(44)
            make.width.equalTo(watchButton.snp.width)
        }
        
    }
    
    
    
}
