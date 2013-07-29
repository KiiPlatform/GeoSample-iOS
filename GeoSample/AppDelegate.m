//
//  AppDelegate.m
//  GeoSample
//
//  Created by Chris on 7/29/13.
//  Copyright (c) 2013 Kii. All rights reserved.
//

#import "AppDelegate.h"

#import "ViewController.h"

#import <KiiSDK/Kii.h>
#import "KiiToolkit.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [Kii beginWithID:@"f482ad90" andKey:@"ccc6ae488d396a4627c1a9a76fea25e3"];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
//    NSError *error;
//    NSString *username = [NSString randomString:12 withCharacterSet:KTCharacterSetAlpha];
//    KiiUser *u = [KiiUser userWithUsername:username andPassword:@"password"];
//    [KiiUser authenticateSynchronous:@"pryHmXdFVhfd" withPassword:@"password" andError:&error];
//    [u performRegistrationSynchronous:&error];
//    NSLog(@"Error: %@", error);
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
