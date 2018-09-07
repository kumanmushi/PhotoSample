//
//  MusicPlayerViewController.swift
//  test
//
//  Created by 村田真矢 on 2018/09/05.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit
import FSPagerView
import Alamofire
import AVFoundation

class MusicPlayerViewController: UIViewController, FSPagerViewDataSource {
    
    private let musicURLString: URL = URL(string: "https://pg.kdtk.net/wp-content/uploads/musicsample.mp3")!
    private let applicationSupportPath = NSHomeDirectory() + "/Library/Application Support"
    
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        self.pagerView.itemSize = CGSize(width: pagerView.frame.height, height: pagerView.frame.height)
        }
    }

    @IBOutlet weak var scrolleView: UIScrollView!
    @IBOutlet weak var underView: UIView!
    
    var count = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pagerView.delegate = self
        
    }

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.count
    }

    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)

        cell.textLabel?.text = String(index)
        cell.imageView?.image = UIImage(named: "AnimalEland")

        return cell
    }
    
    @IBAction func testButtonAction(_ sender: UIButton) {
        
        let fileManager = FileManager.default
        print(fileManager.fileExists(atPath: NSHomeDirectory() + "/Library" + "/musicsample.mp3"))
        
        do {
            // AVAudioPlayerのインスタンス化
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:  NSHomeDirectory() + "/Library" + "/musicsample.mp3"))
            
            // 音声の再生
            audioPlayer.play()
        } catch {
            print("muri")
        }
        
//        self.scrolleView.scrollRectToVisible(self.underView.frame, animated: true)
//        let destination = DownloadRequest.suggestedDownloadDestination(for: .libraryDirectory)
//        Alamofire.download(self.musicURLString, to: destination).responseData(completionHandler: { (response: DownloadResponse<Data>) -> Void in
//            let fileManager = FileManager.default
//            print(fileManager.fileExists(atPath: (response.destinationURL?.absoluteString)!))
//        })
    }
}

extension MusicPlayerViewController: FSPagerViewDelegate {
    
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int) {

        if self.count - 5 == index {
            self.count += 10
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                pagerView.reloadData()
            }
        }
    }
}
