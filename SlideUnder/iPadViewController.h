//
//  iPadViewController.h
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideUnderModel.h"
#import "PhoneViewController.h"
#import "MSSCommunicationController.h"

@interface iPadViewController : UIViewController <MSSCommunicationProtocol>
{
}

@property (strong, nonatomic) SlideUnderModel* model;
@property (strong, nonatomic) IBOutlet UIImageView* bgImageView;
@property (strong, nonatomic) PhoneViewController * phoneViewController;


@end
