//
//  Sign.swift
//  Invitation_App
//
//  Created by Will Johannesen on 8/7/14.
//  Copyright (c) 2014 jciBox. All rights reserved.
//

import UIKit


class Sign: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    @IBOutlet weak var initials: UITextField!
    
    var AD : AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
 
    @IBAction func submitSignature(sender: AnyObject) {
        var userInitials = initials.text
        println(userInitials)
        var signatureTime = NSDate()
        println(signatureTime)
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func Cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        println(AD.ContactData)
        
        var documentsDirectory = NSBundle.mainBundle().pathForResource("minimoose", ofType:"pdf")
        var pdfData = NSData(contentsOfFile:documentsDirectory)
        webView.loadData(pdfData, MIMEType:"application/pdf", textEncodingName:"utf-8", baseURL:nil)
        self.view.addSubview(webView)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



}