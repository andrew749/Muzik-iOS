//
//  CustomController.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-06-05.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

class CustomController: UINavigationController {
    override func viewDidLoad() {
    }
    func addNowPlayingIcon(){
        if(MusicManager.getObjInstance().isLoaded()){
            self.navigationItem.setRightBarButtonItem(UIBarButtonItem(title: "Now Playing", style: UIBarButtonItemStyle.Plain, target: self.viewControllers[0], action: nil), animated: true)
        }
    }
}
