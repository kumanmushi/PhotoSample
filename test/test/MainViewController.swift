//
//  MainViewController.swift
//  test
//
//  Created by 村田真矢 on 2018/09/02.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Player")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
        
        // 選択字のタブバーアイコンの色設定
        self.tabBar.tintColor = UIColor(red: 247/255, green: 240/255, blue: 149/255, alpha: 1)
        
        // 非選択字のタブバーアイコンの色設定
        self.tabBar.unselectedItemTintColor = UIColor.gray
        
        // 選択字のタブバーアイコンのフォントの色
        let selectedAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 10), NSAttributedStringKey.foregroundColor: UIColor.white]
        self.tabBarItem.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        
        // XIBの画面をインスタンス化
        let view: PlayerView = PlayerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        view.translatesAutoresizingMaskIntoConstraints = false
        view.playerViewDelegaet = self
        
        self.view.addSubview(view)
        
        // レイアウトアンカーを使用して制約を作成するための定義
        let margins = self.view.safeAreaLayoutGuide
        
        view.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        view.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: -self.tabBar.frame.height).isActive = true
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        self.view.addSubview(viewController.view)
        
        viewController.view.isHidden = true

    }
}

// ミニプレイヤー画面を隠しプレイヤー画面を表示
extension MainViewController: PlayerViewDeleate {
    func didTap(view: PlayerView) {
        self.viewController.view.isHidden = false
        guard let musicPlayerViewController = viewController as? MusicPlayerViewController else { return }
        musicPlayerViewController.appearView()
    }
}
