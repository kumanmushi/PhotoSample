//
//  Test.swift
//  test
//
//  Created by 村田真矢 on 2018/09/02.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class Test: ButtonBarPagerTabStripViewController, UISearchBarDelegate {
    
    let gray = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "post")
    
    override func viewDidLoad() {
        self.navigationController?.hidesBarsOnSwipe = true
        
        self.buttonBarView.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
        self.settings.style.buttonBarItemBackgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 0)
        self.settings.style.selectedBarBackgroundColor = UIColor(red: 247/255, green: 240/255, blue: 149/255, alpha: 1)
        self.settings.style.buttonBarMinimumLineSpacing = 0
        
        let searchBar = UISearchBar()
        searchBar.backgroundColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1)
        self.navigationItem.titleView = searchBar
        
        searchBar.delegate = self
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        super.viewDidLoad()
        
        self.view.addSubview(gray.view)
        self.addChildViewController(gray)
        self.gray.view.isHidden = true
    }

    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let gray = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "gray")
        let blue = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "blue")
        
        return [gray,blue]
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        
//        self.gray.view.isHidden = false
        self.setView(view: self.gray.view, hidden: false)
        
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
//        self.gray.view.isHidden = true
        self.setView(view: self.gray.view, hidden: true)
    }
    
    func setView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.2, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
}
