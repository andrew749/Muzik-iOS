//
//  MusicManager.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-05-02.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

import Foundation
import AVFoundation
class MusicManager{
    var title:String!
    var url:NSURL!
    var player:AVAudioPlayer!
    static let manager:MusicManager=MusicManager()
    init(){
    }
    func setSong(title:String, url:NSURL ){
        self.title=title
        self.url=url
        self.player=AVAudioPlayer(contentsOfURL: url, error: nil)
        player.prepareToPlay()
        player.play()
    }
    //PLAY
    func play(){
        if((self.player) != nil){
            player.play()
        }
    }
    //PAUSE
    func pause(){
        if((self.player)!=nil){
            player.pause()
        }
    }
    //STOP 
    func stop(){
        if((player)!=nil)
        {
            player.stop()
        }
        player=nil
    }
    
}