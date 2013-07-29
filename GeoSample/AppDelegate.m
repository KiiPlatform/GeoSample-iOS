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
    [Kii beginWithID:@"__APP_ID__" andKey:@"__APP_KEY__"];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

@end
