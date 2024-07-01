//
//  TabViewController.swift
//  MoiveGram
//
//  Created by 김상규 on 6/24/24.
//

import UIKit

final class TabViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        
        let home = UINavigationController(rootViewController: ViewController())
        home.tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house.fill"), tag: 0)
        let searchMovie = UINavigationController(rootViewController: SearchMovieViewController())
        searchMovie.tabBarItem = UITabBarItem(title: "검색하기", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let trending = UINavigationController(rootViewController: TrendingViewController())
        trending.tabBarItem = UITabBarItem(title: "트렌드", image: UIImage(systemName: "flame"), tag: 2)
        
        setViewControllers([home, searchMovie, trending], animated: true)
        
    }
    
    
}
