//
//  Invites.swift
//  Invitation_App
//
//  Created by Stevie Parris on 2014-08-08.
//  Copyright (c) 2014 jciBox. All rights reserved.
//

import UIKit
import MessageUI

class Invites: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet var Templates_Table: UITableView!
    
    @IBOutlet var Contacts_Table: UITableView!
    
    var Contacts : NSMutableArray?
    
    var myAD : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(myAD.ContactData![0].objectForKey("name") as String)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showEmail(sender : AnyObject) {
        var emailTitle = "Test Email"
        var messageBody = "This is a test email body"
        var toRecipents = ["stevie.parris@gmail.com"]
        var mc: MFMailComposeViewController = MFMailComposeViewController()
        mc.mailComposeDelegate = self
        mc.setMessageBody(messageBody, isHTML: false)
        mc.setSubject(emailTitle)
        mc.setToRecipients(toRecipents)
        
        self.presentViewController(mc, animated: true, completion: nil)
    }
    
    func mailComposeController(controller:MFMailComposeViewController, didFinishWithResult result:MFMailComposeResult, error:NSError) {
        switch result.value {
        case MFMailComposeResultCancelled.value:
            NSLog("Mail cancelled")
        case MFMailComposeResultSaved.value:
            NSLog("Mail saved")
        case MFMailComposeResultSent.value:
            NSLog("Mail sent")
        case MFMailComposeResultFailed.value:
            NSLog("Mail sent failure: %@", [error.localizedDescription])
        default:
            break
        }
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return myAD.ContactData!.count
    }
    
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        
        cell.textLabel.textAlignment = NSTextAlignment.Center
        
        if(cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        }
        if(tableView == Contacts_Table)
        {
            cell.textLabel.text = myAD.ContactData![indexPath.row].objectForKey("name") as String
            
        }
        
        return cell as UITableViewCell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        //var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        //.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as UICollectionViewCell
        
        //return cell
        //self.performSegueWithIdentifier("Main", sender: self)
        
        
        var cell = tableView.cellForRowAtIndexPath(indexPath)
        
        if(tableView == Contacts_Table)
        {
            if(cell.textLabel.textColor == UIColor.blackColor())
            {
                cell.textLabel.textColor = UIColor.grayColor()
                showEmail(self)
            }
            else
            {
                cell.textLabel.textColor = UIColor.blackColor()
            }
            
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    }

}
