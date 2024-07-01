//
//  TrendingTrailerWebView.swift
//  MoiveGram
//
//  Created by 김상규 on 7/1/24.
//

import UIKit
import WebKit
import SnapKit

final class TrendingTrailerWebView: UIViewController {
    
    private let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureNavigationBar()
        configureHierarchy()
        configureLayout()
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector (closedWebView))
    }
    
    @objc private func closedWebView() {
        dismiss(animated: true)
    }
    
    private func configureHierarchy() {
        view.addSubview(webView)
    }
    
    private func configureLayout() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureWebView(link: String) {
        let url = URL(string: link)!
        webView.load(URLRequest(url: url))
    }
    
}
