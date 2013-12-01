//
//  ViewController.h
//  LocationApp_2
//
//  Created by rohit bhatnagar on 1/12/13.
//  Copyright (c) 2013 UMS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Firebase/Firebase.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *PhoneNumber;
@property (weak, nonatomic) IBOutlet UITextField *PhNumTxFeild;
@property (weak, nonatomic) IBOutlet UIButton *SubmitBtn;
-(IBAction)submitButton:(id)sender;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic)Firebase* f;
@end
