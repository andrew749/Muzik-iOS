//
//  SearchViewSwift.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-04-29.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

import Foundation
import UIKit
class SearchViewSwift:UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate{
    var items:[Song] = []
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return self.items.count
    }
    @IBOutlet weak var tableView: UITableView!
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            var cell=tableView.dequeueReusableCellWithIdentifier("songIdentifier") as? UITableViewCell
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "songIdentifier")
            }
            if !(indexPath.row>items.endIndex){
                let title:String=self.items[indexPath.row].getSongTitle()
                cell?.textLabel?.text=title
            }
            return cell!
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(MusicManager.getObjInstance().isLoaded()){
            self.navigationItem.rightBarButtonItem=UIBarButtonItem(title: "Now Playing", style: UIBarButtonItemStyle.Plain, target: self, action: "launchPlayer")
            self.navigationItem.rightBarButtonItem?.tintColor=UIColor.whiteColor()
        }else{
            self.navigationItem.rightBarButtonItem=nil
        }
    }
    func launchPlayer(){
        self.performSegueWithIdentifier("showplayer", sender: self)
    }
    var alertView:UIAlertView?
    var activityIndicator:UIActivityIndicatorView?
    //keyboard search button clicked
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        self.searchDisplayController?.searchBar.endEditing(true)
        var query=searchBar.text
        //set frame for activity indicator
        alertView=UIAlertView(title: "Loading Song", message: nil, delegate: nil, cancelButtonTitle: "Cancel")
        activityIndicator=UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        alertView?.addSubview(activityIndicator!)
        activityIndicator!.startAnimating()
        alertView?.show()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {()->Void in
            self.loadSongs(query)
        });
        
    }
    func songsLoaded(){
        dispatch_async(dispatch_get_main_queue(),{
            self.activityIndicator?.stopAnimating()
            self.alertView?.dismissWithClickedButtonIndex(0, animated: true)
            self.searchDisplayController?.searchResultsTableView.reloadData()
        })
    }
    func loadSongs(query:String){
        let stringUrl:String=Constants.searchURL(query)
        var url=NSURL(string:stringUrl)
        var jsonData=NSData(contentsOfURL: url!)
        var err:NSError?
        self.items.removeAll(keepCapacity: false)
        if let data=jsonData{
            if let json: NSDictionary = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSDictionary {
                for var i=0;i<json["url"]!.count;i++ {
                    var obj: NSDictionary=json["url"]![i]! as! NSDictionary
                    for entry in obj{
                        let title:String=entry.key as! String
                        let sURL:String=entry.value as! String
                        let url=NSURL(string:sURL)
                        items.append(Song(songEntry: title, withURL:url))
                    }
                }
            }
        }
        self.songsLoaded()
        
    }
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool{
        return true
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("playSongSearch", sender: nil)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier=="playSongSearch"){
            var player=segue.destinationViewController as! Player
            let indexPath:NSIndexPath=self.searchDisplayController?.searchResultsTableView.indexPathForSelectedRow() as NSIndexPath!
            let song:Song=items[indexPath.row] as Song!
            player.song=song
        }else if(segue.identifier=="showplayer"){
            var player=segue.destinationViewController as! Player
            player.song=MusicManager.getObjInstance().song
        }
    }
    
}