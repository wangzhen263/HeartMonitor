//
//  HRMViewController.h
//  HeartMonitor
//
//  Created by Main Account on 12/13/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface HRMViewController : UIViewController<CBCentralManagerDelegate, CBPeripheralDelegate>
@property (nonatomic, strong) IBOutlet UIImageView *heartImage;
@property (nonatomic, strong) IBOutlet UITextView  *deviceInfo;

// Instance method to get the heart rate BPM information
- (void) getHeartBPMData:(CBCharacteristic *)characteristic error:(NSError *)error;

// Instance methods to grab device Manufacturer Name, Body Location
- (void) getManufacturerName:(CBCharacteristic *)characteristic;
- (void) getBodyLocation:(CBCharacteristic *)characteristic;

// Instance method to perform heart beat animations
- (void) doHeartBeat;
@end
