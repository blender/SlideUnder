//
//  ViewController.h
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MSSCommunicationController.h"
#import "SlideUnderModel.h"
#import "PictureView.h"

@interface iPhoneViewController: UIViewController <MSSCommunicationProtocol>

@property (strong, nonatomic) SlideUnderModel* model;
@end
