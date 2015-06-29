//
//  STATE.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-06-29.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

import Foundation

@objc enum STATE:Int{
    case NOT_PLAYING
    case PLAYING
    case PAUSED
    case STOPPED
    case LOADED
}