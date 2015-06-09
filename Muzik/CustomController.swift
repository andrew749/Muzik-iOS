//
//  CustomController.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-06-05.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

class CustomController: UINavigationController {
    override func viewDidLoad() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addNowPlayingIcon:", name: "com.andrew749.muzik.updatestate", object: nil)
    }
    func addNowPlayingIcon(){
        println("got update notification")
        if(MusicManager.getObjInstance().songLoaded==true){
            self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Now Playing", style: UIBarButtonItemStyle.Plain, target: self.viewControllers[0], action: nil), animated: true)
        }
    }
}
