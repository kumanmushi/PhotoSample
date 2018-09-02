//
//  ViewController.swift
//  test
//
//  Created by 村田真矢 on 2018/08/31.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit
import YPImagePicker

class ViewController: UIViewController, UITabBarControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {

        super.viewDidLoad()
     
        self.tabBarController?.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController == self {
            var config = YPImagePickerConfiguration()
            config.startOnScreen = .library
            
            let picker = YPImagePicker(configuration: config)
            
            picker.didFinishPicking { [unowned picker] items, cancelled in
                if cancelled {
                    print("Picker was canceled")
                }
                
                if let photo = items.singlePhoto {
                    self.imageView.image = photo.image
                }
                UIApplication.shared.statusBarStyle = .lightContent
                UINavigationBar.appearance().isTranslucent = false
                UINavigationBar.appearance().barTintColor = UIColor(red: 36/255, green: 36/255, blue: 36/255, alpha: 1.0)
                picker.dismiss(animated: true, completion: nil)
            }
            
            //ステータスバーの色を白に変更
            UINavigationBar.appearance().barTintColor = UIColor.white
            //ステータスバーの文字色を黒に変更
            UIApplication.shared.statusBarStyle = .default
            
            present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
//        self.tabBarController?.selectedIndex = 1
        sender.setTitle("This Love", for: .normal)        
    }
}

