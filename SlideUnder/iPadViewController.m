//
//  iPadViewController.m
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "iPadViewController.h"
#import "QuartzCore/CALayer.h"
#import "PictureView.h"
#define padding 50

@implementation iPadViewController
@synthesize model;
@synthesize bgImageView;
@synthesize phoneViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    UIImageView* topBar = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyPhotosBar.png"]];
    topBar.clipsToBounds = NO;
    topBar.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
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
    int r = 50;
    int y = (r*cos(theta) + self.view.frame.size.width/2);
    int x = (r*sin(theta) + self.view.frame.size.height/2);
    
    for(int i = 0; i < NUM_IMGS;){
        
        UIImage* img = [model.imgArray objectAtIndex:i];
        
        PictureView* imgView = [[PictureView alloc] initWithImage:img];
        CGRect oldRect = imgView.frame;
        
        CGRect rect =  CGRectMake(x, y, oldRect.size.width, oldRect.size.height);
        imgView.frame = rect;
        
        imgView.clipsToBounds = NO;
        imgView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        
        imgView.layer.shadowColor = [UIColor blackColor].CGColor;
        imgView.layer.shadowOffset = CGSizeMake(0, 2);
        imgView.layer.shadowOpacity = 1;
        imgView.layer.shadowRadius = 2.0;
        imgView.tag = i+1;
        imgView.userInteractionEnabled = YES;
        [self.view addSubview:imgView];
        
        model.visibility[i] = YES;
        
        i++;
        
        theta =+ i*(2*M_PI/NUM_IMGS);
        
        x = (r*cos(theta) + self.view.frame.size.width/2);
        y = (r*sin(theta) + self.view.frame.size.height/2);
        
    }
    
    model.allVisible = YES;
    
    phoneViewController = [[PhoneViewController alloc] init];
    phoneViewController.view.hidden = YES;
    [self.view addSubview:phoneViewController.view];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark MSSCommunicationController Protocol

-(void) newContacs:(NSDictionary *)contacDictionary{
    
    MSSCContactDescriptor *iPadDesc = [contacDictionary objectForKey:[NSNumber numberWithUnsignedChar:iPadID]];
    model.localDescriptor =  iPadDesc;
    
    if (iPadDesc) {
        
        model.isDeviceOnTable = YES;
        model.localDeviceInfo = [DeviceInformation deviceInfoWithCDByteValue:iPadDesc.byteValue andIp:[MSSCommunicationController deviceIp]];
        [[MSSCommunicationController sharedController] setDeviceToCodeine:model.localDeviceInfo];
        
        MSSCContactDescriptor* satelliteDeviceDesc = [contacDictionary objectForKey:[NSNumber numberWithUnsignedChar:iPhoneID]];
        model.satelliteDescriptor = satelliteDeviceDesc;
        
        if(satelliteDeviceDesc){
            
            float distance = [MSSCContactDescriptor distanceFromDescriptor:model.localDescriptor toDescriptor:satelliteDeviceDesc];
            
            if(distance < HALF_AN_IPHONE){
                
                CGPoint position = [MSSCContactDescriptor positionOfDescriptor:satelliteDeviceDesc relativeToDescriptor:model.localDescriptor];
                
                CGRect oldRect = self.phoneViewController.view.frame;
                //TODO FIX REVERSE Y AXIS MOVEMENT ON THE SURFACE
                CGPoint translatedPoint = CGPointMake(position.y+136, -1*((position.x-271)*3)-oldRect.size.height);
                CGPoint inViewPos = CGPointApplyAffineTransform(translatedPoint, self.phoneViewController.view.transform);
                NSLog(@"relative Position:%d, %d", (int)inViewPos.x, (int)inViewPos.y);
                CGRect newRect = CGRectMake(inViewPos.x, inViewPos.y, oldRect.size.width, oldRect.size.height);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.2];
                [self.phoneViewController.view setFrame:newRect];
                [UIView commitAnimations];
                self.phoneViewController.view.hidden = NO;
                
            }else{
                self.phoneViewController.view.hidden = YES;
            }
            
        }
    }
}

-(void) newIPs:(NSDictionary *)ipDictionary {
    
    if(model.localDescriptor){
    
        model.satelliteDeviceInfo = [ipDictionary objectForKey:[NSNumber numberWithUnsignedChar:iPhoneID]];
    
    }
}

@end
