//
//  ViewController.m
//  LocationApp_2
//
//  Created by rohit bhatnagar on 1/12/13.
//  Copyright (c) 2013 UMS. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize PhoneNumber;
@synthesize PhNumTxFeild;
@synthesize SubmitBtn;
@synthesize locationManager;
@synthesize f;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
    locationManager.delegate = self;
    f = [[Firebase alloc] initWithUrl:@"https://ums-ios.firebaseio.com/"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)submitButton:(id)sender{
    NSString *stringval = [NSString stringWithString: PhNumTxFeild.text];
    NSLog(@"Button pressed %@",stringval);
    NSString *empty=nil;
    PhNumTxFeild.text=empty;
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    [stringval writeToFile:fileName atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [locationManager startUpdatingLocation];
    
   
   
  
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/textfile.txt",
                          documentsDirectory];
    
    NSString* content = [NSString stringWithContentsOfFile:fileName
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    
    NSLog(@"value is %@ ",content);
   
    CLLocation *newLocation = [locations lastObject];
    float latitude = newLocation.coordinate.latitude;
    float longitude = newLocation.coordinate.longitude;
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    // NSTimeInterval is defined as double
    NSNumber *timeStampObj = [NSNumber numberWithDouble: timeStamp];
    NSLog(@"latitude %f and longitude %f", latitude, longitude );
    NSMutableArray *numArray = [[NSMutableArray alloc]initWithObjects:[NSNumber numberWithDouble:latitude],[NSNumber numberWithDouble:longitude], timeStampObj,  nil];
   [[f childByAppendingPath:content] setValue:numArray];
      
}


@end
