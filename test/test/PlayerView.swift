//
//  PlayerView.swift
//  test
//
//  Created by 村田真矢 on 2018/09/17.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit

protocol PlayerViewDeleate {
    func didTap(view: PlayerView)
}

class PlayerView: UIView {
    
    @IBOutlet var contentView: UIView!
    
    var playerViewDelegaet: PlayerViewDeleate?
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.loadNib()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.loadNib()
    }
    
    func loadNib(){
        Bundle.main.loadNibNamed("PlayerView", owner: self, options: nil)
        self.addSubview(self.contentView)
        
        contentView.frame = self.frame
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    @IBAction func buttonAtion(_ sender: UIButton) {
        AudioPlayerManager.pause()
    }
    
    @IBAction func tapAction(_ sender: UITapGestureRecognizer) {
        self.playerViewDelegaet?.didTap(view: self)
    }
}
