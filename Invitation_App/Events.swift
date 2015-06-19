//
//  Events.swift
//  Invitation_App
//
//  Created by Stevie Parris on 2014-08-08.
//  Copyright (c) 2014 jciBox. All rights reserved.
//

import UIKit

class Events: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var EventTV: UITableView!
    
    var myGoogleContacts : NSMutableArray!
    
    var EventArray = NSMutableArray()
    
    var AD : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    override func viewDidLoad() {
        
        super.viewDidLoad()
        AD.ContactData = myGoogleContacts
        EventArray.addObject("WOW Party")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return EventArray.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        cell.textLabel.textAlignment = NSTextAlignment.Center
        
        cell.textLabel.text = EventArray[indexPath.row] as String
            
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        //var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        //.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        //return cell
        self.performSegueWithIdentifier("Main", sender: self)
    }
    
}
