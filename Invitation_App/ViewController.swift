//
//  ViewController.swift
//  Invitation_App
//
//  Created by Stevie Parris on 2014-07-28.
//  Copyright (c) 2014 jciBox. All rights reserved.
//

import UIKit


//@objc(Login)
class ViewController: UIViewController, ESignDelegate {
    var signatureData : NSData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        var controller : ESign = segue.destinationViewController as ESign
        controller.delegate = self;
        
        
    }
    func ESignDidFinish(controller : ESign)
    {
        signatureData = controller.dataFromSignature
    }

}

