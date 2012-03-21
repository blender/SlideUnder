//
//  AppDelegate.m
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "AppDelegate.h"
#import "InterDeviceCom.h"
#import "MSSCommunicationController.h"
#import "iPhoneViewController.h"
#import "iPadViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize iPhoneViewController;
@synthesize iPadViewController;
@synthesize sharedSurfaceComController;
@synthesize devComController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    devComController = [InterDeviceComController sharedController];
    
    devComController.delegate = [SlideUnderModel sharedModel];
    
    sharedSurfaceComController = [MSSCommunicationController sharedController];
    [sharedSurfaceComController connectToHost:@"169.254.59.237" onPort:4568];
    //[sharedSurfaceComController connectToHost:@"129.16.213.195" onPort:4568];
    
    devComController = [InterDeviceComController sharedController];
    SlideUnderModel * model = [SlideUnderModel sharedModel];
    devComController.delegate = model;
    
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.iPhoneViewController = [[iPhoneViewController alloc] initWithNibName:@"ViewController_iPhone" bundle:nil];
        self.window.rootViewController = self.iPhoneViewController;
        sharedSurfaceComController.delegate = self.iPhoneViewController;
        [model addObserver:self.iPhoneViewController forKeyPath:@"allVisible" options:NSKeyValueObservingOptionNew context:nil];
        [devComController startServer];
        
    } else {
        self.iPadViewController = [[iPadViewController alloc] initWithNibName:@"ViewController_iPad" bundle:nil];
        self.window.rootViewController = self.iPadViewController;
        sharedSurfaceComController.delegate = self.iPadViewController;

    }

    [NSTimer scheduledTimerWithTimeInterval:0.1 target:(sharedSurfaceComController) selector:@selector(getContacsFromCodeine) userInfo:nil repeats:YES];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:(sharedSurfaceComController) selector:@selector(getDevicesFromCodeine) userInfo:nil repeats:YES];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
