//
//  ViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/4/24.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MovieGram"
        label.textColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .heavy)
        
        return label
    }()
    
    let idTextField: UITextField = {
        let tf = LoginViewTextField()
        tf.setupTF(placeholder: LoginViewTFConstant.placeholder.id.rawValue)
        // NSAttributedString: 문자열에 관련된 속성(폰트, 문자 사이의 간격 등등)을 커스텀할 때 사용
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = LoginViewTextField()
        tf.setupTF(placeholder: LoginViewTFConstant.placeholder.password.rawValue)
        
        return tf
    }()
    
    let nicknameTextField: UITextField = {
        let tf = LoginViewTextField()
        tf.setupTF(placeholder: LoginViewTFConstant.placeholder.nickname.rawValue)
        
        return tf
    }()
    
    let countryTextField: UITextField = {
        let tf = LoginViewTextField()
        tf.setupTF(placeholder: LoginViewTFConstant.placeholder.country.rawValue)
        
        return tf
    }()
    
    let recommandCodeTextField: UITextField = {
        let tf = LoginViewTextField()
        tf.setupTF(placeholder: LoginViewTFConstant.placeholder.recommandCode.rawValue)
        
        return tf
    }()
    
    // let vs lazy var -> self 노란색 경고창 + UILifeCycle
    lazy var joinButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(goHomeView), for: .touchUpInside)
        
        let b = ViewController.self // Meta Type
        
        return button
    }()
    
    let addUserInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가정보 입력", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        
        return button
    }()
    
    let switchButton: UISwitch = {
        let sw = UISwitch()
        sw.onTintColor = .red
        
        
        return sw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        configureHierarchy()
        configureLayout()
        // self.joinButton.addTarget(self, action: #selector(goHomeView), for: .touchUpInside)
    }

    
    func configureHierarchy() {
        view.addSubview(appTitleLabel)
        view.addSubview(idTextField)
        view.addSubview(passwordTextField)
        view.addSubview(nicknameTextField)
        view.addSubview(countryTextField)
        view.addSubview(recommandCodeTextField)
        view.addSubview(joinButton)
        view.addSubview(addUserInfoButton)
        view.addSubview(switchButton)
    }
    
    func configureLayout() {
        appTitleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(44)
        }
        
        idTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(appTitleLabel.snp.bottom).offset(100)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(appTitleLabel.snp.height)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(idTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(appTitleLabel.snp.height)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(passwordTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(appTitleLabel.snp.height)
        }
        
        countryTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(nicknameTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(appTitleLabel.snp.height)
        }
        
        recommandCodeTextField.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(countryTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(appTitleLabel.snp.height)
        }
        
        joinButton.snp.makeConstraints { make in
            make.top.equalTo(recommandCodeTextField.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(60)
        }
        
        addUserInfoButton.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp.bottom).offset(12)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(24)
        }
        
        switchButton.snp.makeConstraints { make in
            make.top.equalTo(joinButton.snp.bottom).offset(12)
            make.trailing.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    
    @objc func goHomeView() {
        print(#function)
        let vc = HomeViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

