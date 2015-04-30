//
//  SearchViewSwift.swift
//  Muzik
//
//  Created by Andrew Codispoti on 2015-04-29.
//  Copyright (c) 2015 Andrew Codispoti. All rights reserved.
//

import Foundation
import UIKit
class SearchViewSwift:UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    var items:[Song] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // Return the number of rows in the section.
        return items.count
    }
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
            var cell=tableView.dequeueReusableCellWithIdentifier("songIdentifier") as? UITableViewCell
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "Component")
            }
            if !(items.endIndex<indexPath.row){
                let title:String=items[indexPath.row].getSongTitle()
                cell!.textLabel!.text=title
            }
            return cell!
    }
    func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath){
            
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        table.delegate=self;
    }
    
    
    //keyboard search button clicked
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        var query=searchBar.text
        dispatch_async(dispatch_get_main_queue(), {()->Void in
            self.loadSongs(query)
            self.table.reloadData()
        });
        
    }
    func loadSongs(query:String){
        let stringUrl:String="http://muzik-api.herokuapp.com/search?songname="+query
        var url=NSURL(string:stringUrl)
        var jsonData=NSData(contentsOfURL: url!)
        var err:NSError?
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
    // called when text ends editing
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }
}