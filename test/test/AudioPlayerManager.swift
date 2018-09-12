//
//  AudioPlayerManager.swift
//  test
//
//  Created by 村田真矢 on 2018/09/12.
//  Copyright © 2018年 村田真矢. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

class AudioPlayerManager: NSObject {

    private static var audioPlayer: AVAudioPlayer?
    
    static func makeAudioPlayer(url: URL) -> Bool {
        
        do {
            
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: .defaultToSpeaker)
            
            try? AVAudioSession.sharedInstance().setActive(true)
            
            UIApplication.shared.beginReceivingRemoteControlEvents()
            
            let commandCenter = MPRemoteCommandCenter.shared()
            commandCenter.playCommand.addTarget(handler: { (event: MPRemoteCommandEvent) in
                self.audioPlayer?.play()

                return .success
            })

            commandCenter.pauseCommand.addTarget(handler: { (event: MPRemoteCommandEvent) in
                self.audioPlayer?.pause()

                return .success
            })

            commandCenter.changePlaybackPositionCommand.addTarget(handler: { (event: MPRemoteCommandEvent) in
                guard let e = event as? MPChangePlaybackPositionCommandEvent else { return .commandFailed }

                self.audioPlayer?.currentTime = e.positionTime

                return MPRemoteCommandHandlerStatus.success
            })

            commandCenter.changePlaybackPositionCommand.isEnabled = false
            commandCenter.playCommand.isEnabled = true
            commandCenter.pauseCommand.isEnabled = true
            
            self.audioPlayer?.prepareToPlay()
            
            return true
        } catch {
            return false
        }
    }
    
    static func setNowPlayngInfo(title: String, artistName: String, image: UIImage) {
        let artwork = MPMediaItemArtwork.init(boundsSize: image.size, requestHandler: { (size) -> UIImage in
            return image
        })
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [
            MPMediaItemPropertyTitle: title,
            MPMediaItemPropertyArtist : artistName,
            MPMediaItemPropertyArtwork : artwork,
            MPNowPlayingInfoPropertyPlaybackRate : 1.0,
            MPMediaItemPropertyPlaybackDuration : self.audioPlayer?.duration ?? 0
        ]
    }
    
    static func play() {
        self.audioPlayer?.play()
    }
    
    static func pause() {
        self.audioPlayer?.pause()
    }
    
    static func stop(){
        self.audioPlayer?.stop()
    }
    
    static func setCurrentTime(time: TimeInterval) {
        self.audioPlayer?.currentTime = time
    }
    
    static func repeatInfinity(bool: Bool) {
        
    }
}
