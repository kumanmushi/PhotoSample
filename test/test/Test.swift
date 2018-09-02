//
//  Test.swift
//  test
//
//  Created by 村田真矢 on 2018/09/02.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Test: ButtonBarPagerTabStripViewController {
    
    override func viewDidLoad() {
        self.buttonBarView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
        self.settings.style.buttonBarItemBackgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 0)
        self.settings.style.selectedBarBackgroundColor = UIColor(red: 247/255, green: 240/255, blue: 149/255, alpha: 1)
        self.settings.style.buttonBarMinimumLineSpacing = 0
        
        let searchBar = UISearchBar()
        searchBar.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
        self.navigationItem.titleView = searchBar
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        super.viewDidLoad()
        
    }

    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let gray = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gray")
        let blue = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "blue")
        
        return [gray,blue]
    }

}
