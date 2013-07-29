//
//  ViewController.h
//  GeoSample
//
//  Created by Chris on 7/29/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

- (IBAction) logOut:(id)sender;
- (IBAction) addCheckin:(id)sender;

@end
