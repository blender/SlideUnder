//
//  SlideUnderModel.h
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#define NUM_IMGS 5
#define iPhoneID 0x09
#define iPadID 0x00
#ifdef SIMULATOR
#define HALF_AN_IPHONE 230
#define HALF_AN_IPAD 300
#endif
#ifndef SIMULATOR
#define HALF_AN_IPHONE 325
#define HALF_AN_IPAD 300
#endif


#import <Foundation/Foundation.h>
#import "InterDeviceCom.h"
#import "MSSCContactDescriptor.h"
#import "DeviceInformation.h"


@interface SlideUnderModel : NSObject <InterDeviceComProtocol>
{

}

@property (strong, nonatomic) NSMutableArray* imgArray;
@property (strong, nonatomic) NSMutableArray* thumbArray;
@property (assign, nonatomic) bool* visibility;
@property (assign, nonatomic) bool isDeviceOnTable;
@property (strong, nonatomic) MSSCContactDescriptor* localDescriptor;
@property (strong, nonatomic) DeviceInformation* localDeviceInfo;
@property (strong, nonatomic) MSSCContactDescriptor* satelliteDescriptor;
@property (strong, nonatomic) DeviceInformation* satelliteDeviceInfo;
@property (assign, nonatomic) BOOL allVisible;

+ (SlideUnderModel *) sharedModel;
- (SlideUnderModel *) init;
- (NSData *) data;
@end