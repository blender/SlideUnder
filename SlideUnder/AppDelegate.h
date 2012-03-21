//
//  AppDelegate.h
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MSSCommunicationController, InterDeviceComController, iPhoneViewController, iPadViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) iPhoneViewController* iPhoneViewController;
@property (strong, nonatomic) iPadViewController* iPadViewController;
@property (strong, nonatomic) MSSCommunicationController* sharedSurfaceComController;
@property (strong, nonatomic) InterDeviceComController* devComController;

@end
