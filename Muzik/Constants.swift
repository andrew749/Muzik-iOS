//
//  Constants.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-07-07.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

import Foundation

@objc class Constants:NSObject{
    
    class func baseURL()->String{
        return "http://muzik-dev.elasticbeanstalk.com"
    }
    
    class func topURL()->String{
        return "\(baseURL())/top"
    }
    
    class func searchURL(query:String)->String{
        let encodedQuery=query.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        return "\(baseURL())/search?songname=\(encodedQuery!)"
    }
    
}