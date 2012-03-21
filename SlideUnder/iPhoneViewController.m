//
//  ViewController.m
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "iPhoneViewController.h"
#import "QuartzCore/CALayer.h"

@implementation iPhoneViewController
@synthesize model;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView* topBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyPhotosBar_s.png"]];
    topBar.clipsToBounds = NO;
    topBar.layer.shadowColor = [UIColor blackColor].CGColor;
    topBar.layer.shadowOffset = CGSizeMake(0, 2);
    topBar.layer.shadowOpacity = 1;
    topBar.layer.shadowRadius = 2.0;
    CGRect oldframe = topBar.frame;
    CGRect newframe = CGRectMake(0, 0, oldframe.size.width, oldframe.size.height);
    [topBar setFrame:newframe];
    [self.view addSubview:topBar];
    
    model = [SlideUnderModel sharedModel];
	
    float theta = 0;
    int r = 20;
    int y = (r*cos(theta) + 50);
    int x = (r*sin(theta) + 50);
    
    for(int i = 0; i < NUM_IMGS;){
        
        UIImage* img = [model.thumbArray objectAtIndex:i];
        
        PictureView* imgView = [[PictureView alloc] initWithImage:img];
        CGRect oldRect = imgView.frame;
        
        CGRect rect =  CGRectMake(x, y, oldRect.size.width, oldRect.size.height);
        imgView.frame = rect;
        
        imgView.clipsToBounds = NO;
        
        imgView.layer.shadowColor = [UIColor blackColor].CGColor;
        imgView.layer.shadowOffset = CGSizeMake(0, 2);
        imgView.layer.shadowOpacity = 1;
        imgView.layer.shadowRadius = 2.0;
        imgView.tag = i+1;
        imgView.userInteractionEnabled = YES;
        imgView.hidden = YES;
        imgView.opaque = YES;
        [self.view addSubview:imgView];
        
        i++;
        
        theta =+ i*(2*M_PI/NUM_IMGS);
        
        x = (r*cos(theta) + 50);
        y = (r*sin(theta) + 50);
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(void) newContacs:(NSDictionary *)contacDictionary {
    
    MSSCContactDescriptor *iPhoneDesc = [contacDictionary objectForKey:[NSNumber numberWithUnsignedChar:iPhoneID]];
    model.localDescriptor =  iPhoneDesc;
    
    if (iPhoneDesc) {
        
        model.isDeviceOnTable = YES;
        model.localDeviceInfo = [DeviceInformation deviceInfoWithCDByteValue:iPhoneDesc.byteValue andIp:[MSSCommunicationController deviceIp]];
        [[MSSCommunicationController sharedController] setDeviceToCodeine:model.localDeviceInfo];
        
        MSSCContactDescriptor* satelliteDeviceDesc = [contacDictionary objectForKey:[NSNumber numberWithUnsignedChar:iPadID]];
        model.satelliteDescriptor = satelliteDeviceDesc;
        
        if(satelliteDeviceDesc){
            
        }
    }
}

#pragma mark -
#pragma mark MSSCommunicationController

-(void) newIPs:(NSDictionary *)ipDictionary {
    
    if(model.localDescriptor){
        
        model.satelliteDeviceInfo = [ipDictionary objectForKey:[NSNumber numberWithUnsignedChar:iPhoneID]];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark -
#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if([keyPath isEqualToString:@"allVisible"]){
        
        NSArray * viewArray = [self.view subviews];
        for(int i = 0; i < viewArray.count; i++){
            UIView *view  = [viewArray objectAtIndex:i];
            
            view.hidden = NO;
        }
    }
    
}

@end
