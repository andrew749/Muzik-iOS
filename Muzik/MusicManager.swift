//
//  MusicManager.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-05-02.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

import Foundation
import AVFoundation
@objc public class MusicManager:NSObject{
    var title:String!
    var url:NSURL!
    var player:AVPlayer!
    static let manager:MusicManager=MusicManager()
    override init(){
    }
    func setSong(title:String, url:NSURL ){
        self.title=title
        self.url=url
        self.player=AVPlayer(URL: url)
        self.play()
    }
    //PLAY
    func play(){
        if((self.player) != nil){
            player.play()
        }
    }
    //PAUSE
    func pause(){
        if((player) != nil){
            player.pause()
        }
        
    }
    //STOP
    func stop(){
        if((player) != nil)
        {
            player.pause()
        }
        player=nil
    }
    static var instance:MusicManager!
    @objc public class func getObjInstance()->MusicManager{
        if (instance == nil)
        {
            instance=MusicManager()
        }
        return instance
    }
    
}