//
//  MusicPlayerViewController.swift
//  test
//
//  Created by 村田真矢 on 2018/09/05.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit
import FSPagerView

class MusicPlayerViewController: UIViewController, FSPagerViewDataSource {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        self.pagerView.itemSize = CGSize(width: pagerView.frame.height, height: pagerView.frame.height)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 10
    }

    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)

        cell.textLabel?.text = "test"
        cell.imageView?.image = UIImage(named: "AnimalEland")

        return cell
    }
}

//extension MusicPlayerViewController: FSPagerViewDelegate {
//
//}
