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
import YPImagePicker

class MusicPlayerViewController: UIViewController, FSPagerViewDataSource {
    
    private let musicURLString: URL = URL(string: "https://pg.kdtk.net/wp-content/uploads/musicsample.mp3")!
    private let applicationSupportPath = NSHomeDirectory() + "/Library/Application Support"
    let cellID: String = "TestCollectionViewCell"
    
    @IBOutlet weak var testttButton: UIButton!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    var audioPlayer: AVAudioPlayer!
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
        self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
//        self.pagerView.register(UINib(nibName: cellID, bundle: nil), forCellWithReuseIdentifier: cellID)
        self.pagerView.transformer = FSPagerViewTransformer(type: .linear)
        self.pagerView.itemSize = CGSize(width: pagerView.frame.height, height: pagerView.frame.height)
            self.pagerView.delegate = self
        }
    }

    @IBOutlet weak var scrolleView: UIScrollView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var underView: UIView!
    
    var count = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        // コードでルートビューコントローラーから遷移させれば動く！
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "post")
        self.view.window?.rootViewController?.present(vc, animated: true, completion: nil)
        
        self.testttButton.isHidden = true
        self.indicator.isHidden = false
        self.indicator.startAnimating()
        
        
        DispatchQueue.global(qos: .default).async {

            Thread.sleep(forTimeInterval: 5)
            
            // 非同期処理などが終了したらメインスレッドでアニメーション終了
            DispatchQueue.main.async {
                // アニメーション終了
                self.testttButton.isHidden = false
                self.indicator.isHidden = true
                self.indicator.stopAnimating()
            }
        }
        
        if !AudioPlayerManager.makeAudioPlayer(url: URL(fileURLWithPath:  NSHomeDirectory() + "/Library" + "/musicsample.mp3")) {
            print("再生失敗")
        }
        
        AudioPlayerManager.play()
        
        let image = #imageLiteral(resourceName: "AnimalEland")
        
        AudioPlayerManager.setNowPlayngInfo(title: "title", artistName: "artist", image: image)
        
//        self.scrolleView.scrollRectToVisible(self.underView.frame, animated: true)
        }
    
    // ボタンで画面を隠す
    @IBAction func hideButtonAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .allowAnimatedContent, animations: {
            self.view.center.y += self.view.frame.height
        }, completion: { (bool: Bool) -> Void in
            self.view.isHidden = true
        })
    }
    
    // プレイヤー画面を表示させる
    func appearView(){
        self.scrolleView.scrollRectToVisible(self.playerView.frame, animated: true)
    }
    
    // 一番上までスクロールし画面を隠す
    func disappearView() {
        self.scrolleView.scrollRectToVisible(CGRect(), animated: true)
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

extension MusicPlayerViewController: UIScrollViewDelegate {
    // 一番上まで来たら画面を隠す
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.bounds.origin.y == 0 {
            self.view.isHidden = true
        }
    }
}
