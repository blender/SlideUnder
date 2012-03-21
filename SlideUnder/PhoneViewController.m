//
//  PhoneViewController.m
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/19/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "PhoneViewController.h"

@implementation PhoneViewController
@synthesize iPhoneImage, iPhoneImageView;
@synthesize model;


-(PhoneViewController*) init{

    self = [super init];
    
    if(self){
        
        iPhoneImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iPhone3G.png" ofType:nil]];
    
        model =[SlideUnderModel sharedModel];
    }
    
    return self;
}

-(void) loadView {
    
    self.view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iPhoneImage.size.width, iPhoneImage.size.height)];
    
}

-(void) viewDidLoad{
    
    iPhoneImageView = [[UIImageView alloc] initWithImage:iPhoneImage];
    [self.view addSubview: iPhoneImageView];
    //imgView.backgroundColor = [UIColor redColor];

}

-(void) viewDidUnload {

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
	
	if ([touch tapCount] == 2) {
		[[InterDeviceComController sharedController] sendData:[model data] toDevice:model.satelliteDeviceInfo];
        
        for(int i =0; i< NUM_IMGS; i++){
            UIView* aView = [[self.view superview] viewWithTag:i+1];
            aView.hidden = YES;
         }
        
        iPhoneImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"iPhone3G_2.png" ofType:nil]];
        iPhoneImageView.image = iPhoneImage;
		return;
	}
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(BOOL) canBecomeFirstResponder {
    
    return  YES;
}

-(BOOL) becomeFirstResponder {
    
    return  YES;
}


@end
