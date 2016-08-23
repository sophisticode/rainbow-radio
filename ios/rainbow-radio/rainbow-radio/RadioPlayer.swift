//
//  RadioPlayer.swift
//  rainbow-radio
//
//  Created by Markus Zehnder on 11.08.16.
//  Copyright © 2016 Sophisticode. All rights reserved.
//

import UIKit
import AVFoundation

class RadioPlayer {

    static var instance : RadioPlayer?
    var audioPlayer : AVPlayer?

    class func sharedInstance() -> RadioPlayer {
        if instance == nil {
            instance = RadioPlayer()
        }
        return instance!
    }
    
    func startWithUrl(_ url : URL) {
        if audioPlayer != nil {
            stop()
        }
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            audioPlayer = AVPlayer(url: url)
            audioPlayer!.play()
        }
        catch let error as NSError {
            print("Failed to start player: \(error.localizedDescription)")
        }
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func resume() {
        audioPlayer?.play()
    }
    
    func stop() {
        audioPlayer?.pause()
        audioPlayer = nil
    }
}
