//
//  HRMViewController.m
//  HeartMonitor
//
//  Created by Main Account on 12/13/13.
//  Copyright (c) 2013 Razeware LLC. All rights reserved.
//

#import "HRMViewController.h"

#define POLARH7_HRM_DEVICE_INFO_SERVICE_UUID @"180A"
#define POLARH7_HRM_HEART_RATE_SERVICE_UUID @"180D"

#define POLARH7_HRM_MEASUREMENT_CHARACTERISTIC_UUID @"2A37"
#define POLARH7_HRM_BODY_LOCATION_CHARACTERISTIC_UUID @"2A38"
#define POLARH7_HRM_MANUFACTURER_NAME_CHARACTERISTIC_UUID @"2A29"

@interface HRMViewController ()
@property (nonatomic, strong) CBCentralManager* centralManager;
@property (nonatomic, strong) CBPeripheral* polarH7HRMPeripheral;

// Properties to hold data characteristics for the peripheral device
@property (nonatomic, strong) NSString   *connected;
@property (nonatomic, strong) NSString   *bodyData;
@property (nonatomic, strong) NSString   *manufacturer;
@property (nonatomic, strong) NSString   *polarH7DeviceData;
@property (assign) uint16_t heartRate;

// Properties to handle storing the BPM and heart beat
@property (nonatomic, strong) UILabel    *heartRateBPM;
@property (nonatomic, retain) NSTimer    *pulseTimer;
@end

@implementation HRMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _polarH7DeviceData = nil;
    [self.view setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
//    [self.heartImage setImage:[UIImage imageNamed:@"HeartImage"]];
    
    // Clear out textView
    [_deviceInfo setText:@""];
    [_deviceInfo setTextColor:[UIColor blueColor]];
    [_deviceInfo setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    [_deviceInfo setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:25]];
    [_deviceInfo setUserInteractionEnabled:NO];
    
    // Create your Heart Rate BPM Label
    _heartRateBPM = [[UILabel alloc] initWithFrame:CGRectMake(55, 30, 75, 50)];
    [_heartRateBPM setTextColor:[UIColor whiteColor]];
    [_heartRateBPM setText:[NSString stringWithFormat:@"%i", 0]];
    [_heartRateBPM setFont:[UIFont fontWithName:@"Futura-CondensedMedium" size:28]];
    [_heartImage addSubview:self.heartRateBPM];
    
    // Scan for all available CoreBluetooth LE devices
    NSArray *services = @[[CBUUID UUIDWithString:POLARH7_HRM_HEART_RATE_SERVICE_UUID], [CBUUID UUIDWithString:POLARH7_HRM_DEVICE_INFO_SERVICE_UUID]];
    _centralManager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    [_centralManager scanForPeripheralsWithServices:nil options:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CBCentralManagerDelegate
// method called whenever you have successfully connected to the BLE peripheral
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
}

// CBCentralManagerDelegate - This is called with the CBPeripheral class as its main input parameter. This contains most of the information there is to know about a BLE peripheral.
- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI
{
    NSString *localName = [advertisementData objectForKey:CBAdvertisementDataLocalNameKey];
    if ([localName length] > 0) {
        NSLog(@"Found BLE: %@", localName);
//        NSLog(@"Found the heart rate monitor: %@", localName);
//        [self.centralManager stopScan];
//        self.polarH7HRMPeripheral = peripheral;
//        peripheral.delegate = self;
//        [self.centralManager connectPeripheral:peripheral options:nil];
    }
}

// method called whenever the device state changes.
- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    // Determine the state of the peripheral
    if ([central state] == CBCentralManagerStatePoweredOff) {
        NSLog(@"CoreBluetooth BLE hardware is powered off");
    }
    else if ([central state] == CBCentralManagerStatePoweredOn) {
        NSLog(@"CoreBluetooth BLE hardware is powered on and ready");
    }
    else if ([central state] == CBCentralManagerStateUnauthorized) {
        NSLog(@"CoreBluetooth BLE state is unauthorized");
    }
    else if ([central state] == CBCentralManagerStateUnknown) {
        NSLog(@"CoreBluetooth BLE state is unknown");
    }
    else if ([central state] == CBCentralManagerStateUnsupported) {
        NSLog(@"CoreBluetooth BLE hardware is unsupported on this platform");
    }
}

#pragma mark - CBPeripheralDelegate
// CBPeripheralDelegate - Invoked when you discover the peripheral's available services.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(NSError *)error
{
}

// Invoked when you discover the characteristics of a specified service.
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error
{
}

// Invoked when you retrieve a specified characteristic's value, or when the peripheral device notifies your app that the characteristic's value has changed.
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error
{
}

#pragma mark - CBCharacteristic helpers

// Instance method to get the heart rate BPM information
- (void) getHeartBPMData:(CBCharacteristic *)characteristic error:(NSError *)error
{
}
// Instance method to get the manufacturer name of the device
- (void) getManufacturerName:(CBCharacteristic *)characteristic
{
}
// Instance method to get the body location of the device
- (void) getBodyLocation:(CBCharacteristic *)characteristic
{
}
// Helper method to perform a heartbeat animation
- (void)doHeartBeat {
}
@end
