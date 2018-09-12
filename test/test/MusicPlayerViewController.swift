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
import MediaPlayer

class MusicPlayerViewController: UIViewController, FSPagerViewDataSource {
    
    private let musicURLString: URL = URL(string: "https://pg.kdtk.net/wp-content/uploads/musicsample.mp3")!
    private let applicationSupportPath = NSHomeDirectory() + "/Library/Application Support"
    let cellID: String = "TestCollectionViewCell"
    
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
//        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.pagerView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        self.pagerView.itemSize = CGSize(width: pagerView.frame.height, height: pagerView.frame.height)
            self.pagerView.delegate = self
        }
    }

    @IBOutlet weak var scrolleView: UIScrollView!
    @IBOutlet weak var underView: UIView!
    
    var count = 10
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        
        
    }

    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.count
    }

    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
//        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: cellID, at: index) as! TestCollectionViewCell
        cell.backgroundColor = UIColor.brown

//        cell.textLabel?.text = String(index)
//        cell.imageView?.image = UIImage(named: "AnimalEland")

        return cell
    }
    
    @IBAction func testButtonAction(_ sender: UIButton) {
        
        
        
        if !AudioPlayerManager.makeAudioPlayer(url: URL(fileURLWithPath:  NSHomeDirectory() + "/Library" + "/musicsample.mp3")) {
            print("再生失敗")
        }
        
        AudioPlayerManager.play()
        
        let image = #imageLiteral(resourceName: "AnimalEland")
        
        AudioPlayerManager.setNowPlayngInfo(title: "title", artistName: "artist", image: image)
        
//        self.scrolleView.scrollRectToVisible(self.underView.frame, animated: true)
        
        let fileManager = FileManager.default
        print(fileManager.fileExists(atPath: NSHomeDirectory() + "/Library" + "/musicsample.mp3"))
        
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

extension MusicPlayerViewController: AVAudioPlayerDelegate {
    
    // 再生終了時の処理
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        AudioPlayerManager.play()
    }
    
    // 割り込み開始時にプレーヤーを制御するデリゲートメソッド
    private func audioPlayerBeginInterruption(player: AVAudioPlayer) {
        AudioPlayerManager.pause()
    }
    
    // 割り込み終了時にプレーヤーを制御するデリゲートメソッド
    private func audioPlayerEndInterruption(player: AVAudioPlayer) {
        // 復帰処理
    }
}
