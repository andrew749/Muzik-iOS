//
//  ImageLoader.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-07-10.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

import Foundation
@objc protocol LoadingDelegate{
    func doneLoading(data:AnyObject?)
}
class ImageLoader:NSObject{
    class func getImage(query:String)->UIImage?{
        let url=NSURL(string: Constants.imageURL(query))!
        let request = NSURLRequest(URL: url)
        var response:NSURLResponse?
        var error:NSError?
        let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: &response, error: &error)
        if let d=data{
            if let safeData:NSDictionary = NSJSONSerialization.JSONObjectWithData(d, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary{
                if let responseData:NSDictionary = safeData["responseData"] as? NSDictionary{
                    if let results: NSArray = responseData["results"] as? NSArray{
                        if let result:NSDictionary = results[0] as? NSDictionary{
                            if let urlString:String = result["url"] as? String{
                                if let imageData = NSData(contentsOfURL: NSURL(string: urlString)!){
                                    return UIImage(data: imageData)
                                }
                            }
                        }
                    }
                }
            }
        }
        return nil
    }
    class func getImageAsync(callback:LoadingDelegate,query:String){
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), {
            if let image = ImageLoader.getImage(query){
                callback.doneLoading(image)
            }
        })
    }
}