//
//  TestTableViewController.swift
//  test
//
//  Created by 村田真矢 on 2018/09/06.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit

class TestTableViewController: UIViewController {

    @IBOutlet weak var testTableView: UITableView!
    
    var count = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.testTableView.register(UINib(nibName: "RecommendTableViewCell", bundle: nil), forCellReuseIdentifier: "RecommendTableViewCell")
    }

}

extension TestTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendTableViewCell") as! RecommendTableViewCell
        return cell
    }
    
}

extension TestTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print(tableView.numberOfRows(inSection: 0))
        
        if indexPath.row  == self.count - 1 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
//                tableView.beginUpdates()
                self.count += 10
                
//                var indexPath = [IndexPath]()
//                indexPath.append(IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0))
//                indexPath.append(IndexPath(row: self.count - 1, section: 0))
                
//                tableView.insertRows(at: indexPath, with: .none)
                tableView.reloadData()
//                tableView.endUpdates()
            }
        }
    }

}
