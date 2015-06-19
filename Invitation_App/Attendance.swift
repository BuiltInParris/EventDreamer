//
//  Attendance.swift
//  Invitation_App
//
//  Created by Stevie Parris on 2014-08-11.
//  Copyright (c) 2014 jciBox. All rights reserved.
//

import UIKit

class Attendance: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var Contact_Name_TV: UITableView!
    
    @IBOutlet weak var X_Sign_TV: UITableView!
    
    var myAD : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return myAD.ContactData!.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        
        //var data = fatafat[indexPath.row]
        
        cell.textLabel.textAlignment = NSTextAlignment.Center

        
        if(tableView == Contact_Name_TV)
        {
            cell.textLabel.text = myAD.ContactData![indexPath.row].objectForKey("name") as String
            
        }
        else if(tableView == X_Sign_TV)
        {
            cell.textLabel.text = ""
        }
        
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        
        
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if(tableView == Contact_Name_TV)
        {
            if(cell.backgroundColor == UIColor.clearColor())
            {
                cell.backgroundColor = UIColor.yellowColor()
                cell.textLabel.textColor = UIColor.grayColor()
            }
            else
            {
                cell.backgroundColor = UIColor.clearColor()
                cell.textLabel.textColor = UIColor.blackColor()
            }
            
        }
        else if(tableView == X_Sign_TV)
        {
            if(cell.textLabel.text == "X")
            {
                cell.textLabel.text = ""
            }
            else
            {
                
                self.performSegueWithIdentifier("Sign", sender: self)
                cell.textLabel.text = "X"
            }
        }
        
    }
    
    func matchScrollViewInY(firstguy:UIScrollView, secondguy:UIScrollView) {
        var offset = firstguy.contentOffset;
        offset.y = secondguy.contentOffset.y;
        firstguy.contentOffset = offset;
    }
    
    func matchScrollViewInX(firstguy:UIScrollView, secondguy:UIScrollView) {
        var offset = firstguy.contentOffset;
        offset.x = secondguy.contentOffset.x;
        firstguy.contentOffset = offset;
    }
    
    //Constant function called every time the scrollview moves and then uses the match function to make the two's locations equal.
    func scrollViewDidScroll(scrollView2: UIScrollView!) {
        if(!scrollView2.isEqual(Contact_Name_TV)) {
            matchScrollViewInY(Contact_Name_TV, secondguy: X_Sign_TV)
        }
        else
        {
            matchScrollViewInY(X_Sign_TV, secondguy: Contact_Name_TV)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        //var controller : ESign = segue.destinationViewController as ESign
        //controller.delegate = self;
        
        
    }

}
