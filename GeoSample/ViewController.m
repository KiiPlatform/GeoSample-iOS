//
//  ViewController.m
//  GeoSample
//
//  Created by Chris on 7/29/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import "ViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <KiiSDK/Kii.h>
#import "KiiToolkit.h"

#define CHECKIN_BUCKET      @"checkins"
#define LOCATION_KEY        @"location"

@interface ViewController () {
    BOOL _loaded;
}

- (void) showLogin;

@end

@implementation ViewController

- (void) showLogin
{
    KTLoginViewController *vc = [[KTLoginViewController alloc] init];
    [self presentViewController:vc animated:TRUE completion:nil];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // if we don't have an authenticated user
    if(![KiiUser loggedIn]) {
        
        // show a login
        [self showLogin];
    } else {
        
        // show a loader to the user
        [KTLoader showLoader:@"Loading nearby checkins..."];
        
        // get the user's location and use it as our center point
        KiiGeoPoint *center = [[KiiGeoPoint alloc] initWithLatitude:_mapView.userLocation.coordinate.latitude
                                                       andLongitude:_mapView.userLocation.coordinate.longitude];
        
        // create the clause for our query
        // we want to get all checkins within 100km of the user's current location
        KiiClause *clause = [KiiClause geoDistance:LOCATION_KEY
                                            center:center
                                            radius:100000 // within 100km
                                   putDistanceInto:nil];
        
        // create the query
        KiiQuery *query = [KiiQuery queryWithClause:clause];
        
        KiiBucket *bucket = [[KiiUser currentUser] bucketWithName:CHECKIN_BUCKET];
        
        NSLog(@"Executing query near %g, %g", _mapView.userLocation.coordinate.latitude, _mapView.userLocation.coordinate.longitude);
        
        // execute the query asynchronously
        [bucket executeQuery:query
                   withBlock:^(KiiQuery *query, KiiBucket *bucket, NSArray *results, KiiQuery *nextQuery, NSError *error) {
                       
                       NSLog(@"Executed query (%@) => %@", error, results);
                       
                       if(error == nil) {
                           
                           // iterate through our results
                           for(KiiObject *o in results) {
                               
                               // extract the geopoint from the object
                               KiiGeoPoint *pt = [o getGeoPointForKey:LOCATION_KEY];
                               
                               // create a pin and show it on the map
                               MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
                               [point setCoordinate:CLLocationCoordinate2DMake(pt.latitude, pt.longitude)];
                               [_mapView addAnnotation:point];
                           }
                           
                           // hide the loading alert
                           [KTLoader hideLoader];
                           
                       } else {
                           
                           // tell our user something went wrong
                           [KTLoader showLoader:@"Error loading checkins!"
                                       animated:TRUE
                                  withIndicator:KTLoaderIndicatorError
                                andHideInterval:KTLoaderDurationAuto];
                           
                       }
                       
                   }];

    }
    
}

#pragma mark - IBActions
- (IBAction) logOut:(id)sender
{
    // log the user out
    [KiiUser logOut];
    
    // show the login view, since we don't allow
    // users to see the main view without being logged in
    [self showLogin];
}

- (IBAction) addCheckin:(id)sender
{
    [KTLoader showLoader:@"Creating checkin..."];

    // Get the current user's location
    CGFloat latitude = _mapView.userLocation.coordinate.latitude;
    CGFloat longitude = _mapView.userLocation.coordinate.longitude;
    
    // create a geopoint
    KiiGeoPoint *point = [[KiiGeoPoint alloc] initWithLatitude:latitude
                                                  andLongitude:longitude];
    
    // create a kiiobject
    KiiObject *obj = [[[KiiUser currentUser] bucketWithName:CHECKIN_BUCKET] createObject];
    
    // add the geopoint to the object
    [obj setGeoPoint:point forKey:LOCATION_KEY];
    
    // save it to the backend
    [obj saveWithBlock:^(KiiObject *object, NSError *error) {
        
        // determine whether or not we were successful
        BOOL success = (error == nil);
        
        // set up the dialog
        NSString *completionString = success ? @"Done saving" : @"Error saving";
        KTLoaderIndicatorType indicator = success ? KTLoaderIndicatorSuccess : KTLoaderIndicatorError;
        
        // show the user a dialog with result
        [KTLoader showLoader:completionString
                    animated:TRUE
               withIndicator:indicator
             andHideInterval:KTLoaderDurationAuto];
        
        // if our request was successful
        if(success) {
            
            // add the point to our map
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            [point setCoordinate:CLLocationCoordinate2DMake(latitude, longitude)];
            [_mapView addAnnotation:point];
        }
    }];
    
}

#pragma mark - MKMapView Delegate

// this is called whenever the user's location changes
- (void) mapView:(MKMapView*)mapView didUpdateUserLocation:(MKUserLocation*)userLocation
{
    
    // auto-zoom to the user's location
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.1, 0.1);
    [mapView setRegion:mapRegion animated:YES];

}

@end
