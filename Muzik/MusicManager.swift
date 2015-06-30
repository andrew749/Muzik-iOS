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
    var song:Song?
    var state:STATE=STATE.NOT_PLAYING

    static let manager:MusicManager=MusicManager()
    override init(){
    }
    func setSong(title:String, url:NSURL ){
        self.title=title
        self.url=url
        self.song=Song(songEntry: self.title, withURL: self.url)
        self.player=AVPlayer(URL: url)
        NSNotificationCenter.defaultCenter().postNotification(NSNotification(name: "com.andrew749.muzik.updatestate", object: nil))
        self.play()
    }
    //PLAY
    func play(){
        if((self.player) != nil){
            player.play()
            state=STATE.PLAYING
        }
    }
    //PAUSE
    func pause(){
        if((player) != nil){
            player.pause()
            state=STATE.PAUSED
        }
        
    }
    func toggleSong(){
        if(state==STATE.PLAYING){
            self.pause()
        }else if (state==STATE.PAUSED){
            self.play()
        }
    }
    //STOP
    func stop(){
        if((player) != nil)
        {
            player.pause()
            state=STATE.STOPPED
        }
        player=nil
    }
    func isLoaded()->Bool{
        return state==STATE.PLAYING||state==STATE.PAUSED||state==STATE.LOADED
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
                if(player.currentItem != nil){
                    return player.currentItem.currentTime()
                }
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