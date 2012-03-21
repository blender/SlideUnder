//
//  SlideUnderModel.m
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "SlideUnderModel.h"

@implementation SlideUnderModel

@synthesize imgArray;
@synthesize thumbArray;
@synthesize visibility, allVisible;
@synthesize isDeviceOnTable;
@synthesize localDescriptor, localDeviceInfo, satelliteDescriptor, satelliteDeviceInfo;


+ (SlideUnderModel *) sharedModel
{
    static dispatch_once_t pred = 0;
    __strong static SlideUnderModel* _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init]; // or some other init method
    });
    return _sharedObject;
}

- (SlideUnderModel *) init{
    
    self = [super init];
    
    if(self){
        
        NSString* imgFiles[NUM_IMGS] = { @"building_", @"gbg_", @"go_", @"lion_", @"street_"};
        
        imgArray = [NSMutableArray arrayWithCapacity:NUM_IMGS];
        thumbArray = [NSMutableArray arrayWithCapacity:NUM_IMGS];
        bool* visible = malloc(NUM_IMGS*sizeof(bool));
        visibility = visible;
        
        for(int i = 0; i<NUM_IMGS; i++){
            
            NSString* imgFileName = [NSString stringWithFormat:@"%@%@",imgFiles[i], @"n.jpg"];  
            UIImage* img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imgFileName ofType:nil]];
            [imgArray insertObject:img atIndex:i];
            
            NSString* thumbFileName = [NSString stringWithFormat:@"%@%@", imgFiles[i], @"s.jpg"];  
            UIImage* thumb = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:thumbFileName ofType:nil]];
            [thumbArray insertObject:thumb atIndex:i];
            
            visibility[i] = NO;
        }
        
        allVisible = NO;
        isDeviceOnTable = NO;
        localDeviceInfo = nil;
        localDescriptor = nil;
        satelliteDescriptor = nil;
        satelliteDeviceInfo = nil;
        
    }   
    
    return self;
}


- (NSData *) data {

    NSData *data = [NSData dataWithBytes:visibility length:NUM_IMGS*sizeof(bool)];

    return  data;
}

#pragma mark -
#pragma mark InterDeviceCom Protocol

-(void) receivedData:(NSData *)data fromHost:(NSString *)host {

    bool* newVisibility = malloc(NUM_IMGS*sizeof(bool));    
    memcpy(newVisibility, [data bytes], NUM_IMGS*sizeof(bool));
    bool* oldVisibility = visibility;
    self.visibility = newVisibility;
    free(oldVisibility);

    self.allVisible = newVisibility[0];
}

-(void)dealloc{

    free(visibility);

}

@end
