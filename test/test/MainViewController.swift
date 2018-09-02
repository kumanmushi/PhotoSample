//
//  MainViewController.swift
//  test
//
//  Created by 村田真矢 on 2018/09/02.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

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
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
