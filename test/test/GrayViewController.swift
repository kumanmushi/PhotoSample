//
//  GrayViewController.swift
//  test
//
//  Created by 村田真矢 on 2018/09/02.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class GrayViewController: UIViewController, IndicatorInfoProvider {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "Gray")
    }

}
