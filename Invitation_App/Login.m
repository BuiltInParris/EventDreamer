//
//  Login.m
//  Invitation_App
//
//  Created by Stevie Parris on 2014-08-08.
//  Copyright (c) 2014 jciBox. All rights reserved.
//

#import "Login.h"
#import "Invitation_App-Swift.h"

@interface Login ()

@end

@implementation Login

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    googleContacts = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getContacts:(id)sender {
    if ([[self.usernameTxt text] isEqual:@""] || [[self.passwordTxt text] isEqual:@""]) {
        NSLog(@"Username and Password is Required.");
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                            message:@"Username and Password is Required."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    } else {
        NSLog(@"Get Google Contacts");
        [self getGoogleContacts];
    }
}

-(void)getGoogleContacts
{
    GDataServiceGoogleContact *service = [self contactService];
    GDataServiceTicket *ticket;
    
    BOOL shouldShowDeleted = TRUE;
    
    // request a whole buncha contacts; our service object is set to
    // follow next links as well in case there are more than 2000
    const int kBuncha = 2000;
    
    NSURL *feedURL = [GDataServiceGoogleContact contactFeedURLForUserID:kGDataServiceDefaultUser];
    
    GDataQueryContact *query = [GDataQueryContact contactQueryWithFeedURL:feedURL];
    [query setShouldShowDeleted:shouldShowDeleted];
    [query setMaxResults:kBuncha];
    
    ticket = [service fetchFeedWithQuery:query
                                delegate:self
                       didFinishSelector:@selector(contactsFetchTicket:finishedWithFeed:error:)];
    
    [self setContactFetchTicket:ticket];
}

- (void)setContactFetchTicket:(GDataServiceTicket *)ticket
{
    mContactFetchTicket = ticket;
}

- (GDataServiceGoogleContact *)contactService
{
    static GDataServiceGoogleContact* service = nil;
    
    if (!service) {
        service = [[GDataServiceGoogleContact alloc] init];
        
        [service setShouldCacheResponseData:YES];
        [service setServiceShouldFollowNextLinks:YES];
    }
    
    // update the username/password each time the service is requested
    NSString *username = [self.usernameTxt text];
    NSString *password = [self.passwordTxt text];
    
    [service setUserCredentialsWithUsername:username
                                   password:password];
    
    return service;
}

// contacts fetched callback
- (void)contactsFetchTicket:(GDataServiceTicket *)ticket
           finishedWithFeed:(GDataFeedContact *)feed
                      error:(NSError *)error {
    
    if (error) {
        NSDictionary *userInfo = [error userInfo];
        NSLog(@"Contacts Fetch error :%@", [userInfo objectForKey:@"Error"]);
        if ([[userInfo objectForKey:@"Error"] isEqual:@"BadAuthentication"]) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                message:@"Authentication Failed"
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        } else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                                message:@"Failed to get Contacts."
                                                               delegate:self
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil, nil];
            [alertView show];
        }
    } else {
        
        NSArray *contacts = [feed entries];
        NSLog(@"Contacts Count: %d ", [contacts count]);
        [googleContacts removeAllObjects];
        for (int i = 0; i < [contacts count]; i++) {
            GDataEntryContact *contact = [contacts objectAtIndex:i];
            
            // Name
            NSString *ContactName = [[[contact name] fullName] contentStringValue];
            NSLog(@"Name    :  %@", ContactName);
            
            // Email
            GDataEmail *email = [[contact emailAddresses] objectAtIndex:0];
            NSString *ContactEmail =  @"";
            if (email && [email address]) {
                ContactEmail = [email address];
                NSLog(@"EmailID :  %@", ContactEmail);
            }
            
            /*
            // Phone
            GDataPhoneNumber *phone = [[contact phoneNumbers] objectAtIndex:0];
            NSString *ContactPhone = @"";
            if (phone && [phone contentStringValue]) {
                ContactPhone = [phone contentStringValue];
                NSLog(@"Phone   :  %@", ContactPhone);
            }
            
            // Address
            GDataStructuredPostalAddress *postalAddress = [[contact structuredPostalAddresses] objectAtIndex:0];
            NSString *address = @"";
            if (postalAddress && [postalAddress formattedAddress]) {
                NSLog(@"Formatted Address   :  %@", [postalAddress formattedAddress]);
                address = [postalAddress formattedAddress];
            }
            
            // Birthday
            NSString *dob = @"";
            if ([contact birthday]) {
                dob = [contact birthday];
                NSLog(@"dob   :  %@", dob);
            }
            
            // Notes
            GDataEntryContent *content = [contact content];
            NSString *notes = @"";
            if (content && [content contentStringValue]) {
                notes = [content contentStringValue];
                NSLog(@"Notes   :  %@", notes);
            }*/
            
            if (!ContactName || !(ContactEmail) ) {
                NSLog(@"Empty Contact Fields. Not Adding.");
            }
            else
            {
                NSArray *keys = [[NSArray alloc] initWithObjects:@"name", @"emailId", nil];
                NSArray *objs = [[NSArray alloc] initWithObjects:ContactName, ContactEmail, nil];
                NSDictionary *dict = [[NSDictionary alloc] initWithObjects:objs forKeys:keys];
                
                [googleContacts addObject:dict];
            }
        }
        NSSortDescriptor *descriptor =
        [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(localizedCaseInsensitiveCompare:)];
        [googleContacts sortUsingDescriptors:[NSArray arrayWithObjects:descriptor, nil]];
        
        // YOU HAVE YOUR GOOGLE CONTACTS IN 'googleContacts'. Do whatever you want to do with it.
        
        NSString *message = [[NSString alloc] initWithFormat:@"Fetched %d contacts.", [googleContacts count]];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        
        // do any setup you need for myNewVC
        [self performSegueWithIdentifier:@"Events" sender:self];
        //Contact_Data *jake;
        
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Events *newVC = segue.destinationViewController;
    newVC.myGoogleContacts = googleContacts;
    
    
}

@end
