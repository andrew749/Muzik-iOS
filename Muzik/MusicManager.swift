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
    var songLoaded:Bool=false
    var loaded:Bool=false
    var playing:Bool=false
    static let manager:MusicManager=MusicManager()
    override init(){
    }
    func setSong(title:String, url:NSURL ){
        self.title=title
        self.url=url
        self.player=AVPlayer(URL: url)
        songLoaded=true;
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "com.andrew749.muzik.updatestate", object: nil))
        self.play()
    }
    //PLAY
    func play(){
        playing=true
        if((self.player) != nil){
            player.play()
            self.loaded=true
        }
    }
    //PAUSE
    func pause(){
        if((player) != nil){
            player.pause()
            self.loaded=true
        }
        
    }
    //STOP
    func stop(){
        playing=false
        self.loaded=false
        if((player) != nil)
        {
            player.pause()
        }
        player=nil
    }
    func isLoaded()->Bool{
        return self.loaded
    }
    func seek(time:Int){
        if ((player) != nil){
            let a:Int64=Int64(time)
            let t=CMTimeMake( a, 1 as Int32)
            player.seekToTime(t)
        }
    }
    func songLength()->CMTime{
        if(player != nil){
            return player.currentItem.duration
        }
        return CMTime()
    }
    func getTime()->CMTime{
        if player != nil{
            if (isLoaded()){
                return player.currentItem.currentTime()
            }
        }
        return CMTime()
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