//
//  Login.h
//  Invitation_App
//
//  Created by Stevie Parris on 2014-08-08.
//  Copyright (c) 2014 jciBox. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDataFeedContact.h"
#import "GDataContacts.h"
//#import "Invitation_App-Swift.h"

@interface Login : UIViewController {
    NSMutableArray *googleContacts;
    
    GDataServiceTicket *mContactFetchTicket;
    NSError *mContactFetchError;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;


- (IBAction)getContacts:(id)sender;
@end
