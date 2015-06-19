//
//  ViewController.h
//  ESignature
//
//  Created by Suraj on 23/01/14.
//  Copyright (c) 2014 Suraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ESign;

@protocol ESignDelegate

- (void)ESignDidFinish:(ESign *) controller;

@end


@interface ESign : UIViewController {
    CGPoint lastPoint;
	UIImageView *drawImage;
	BOOL mouseSwiped;
	int mouseMoved;
    UIButton *btnDone;
}

@property (strong, nonatomic)
NSData *dataFromSignature;
@property (weak, nonatomic) id <ESignDelegate> delegate;


@end