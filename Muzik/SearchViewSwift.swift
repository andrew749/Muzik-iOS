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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
        }
    }
    func launchPlayer(){
        self.performSegueWithIdentifier("showplayer", sender: self)
    }
    //keyboard search button clicked
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        var query=searchBar.text
        dispatch_async(dispatch_get_main_queue(), {()->Void in
            self.loadSongs(query)
            self.searchDisplayController?.searchResultsTableView.reloadData()
            searchBar.resignFirstResponder()
        });
        
    }
    
    func loadSongs(query:String){
        
        let encodedQuery:String=query.stringByReplacingOccurrencesOfString(" ", withString: "_", options: NSStringCompareOptions.LiteralSearch, range: nil)
        let stringUrl:String="http://muzik.elasticbeanstalk.com/search?songname="+encodedQuery
        var url=NSURL(string:stringUrl)
        var jsonData=NSData(contentsOfURL: url!)
        var err:NSError?
        self.items.removeAll(keepCapacity: false)
        if let json: NSArray = NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers, error: &err) as? NSArray {
            for var i=0;i<json.count;i++ {
                var obj=json[i]
                let title:String=obj["title"] as! String!
                let sURL:String=(obj["url"] as! NSArray!)[0] as! String
                let url=NSURL(string:sURL)
                items.append(Song(songEntry: title, withURL:url))
            }
        }
        
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
            let indexPath:NSIndexPath=self.searchDisplayController?.searchResultsTableView.indexPathForSelectedRow() as! NSIndexPath!
            let song:Song=items[indexPath.row] as! Song!
            player.song=song
        }else if(segue.identifier=="showplayer"){
            var player=segue.destinationViewController as! Player
            player.song=MusicManager.getObjInstance().song
        }
    }
    
}