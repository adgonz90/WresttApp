//
//  AppDelegate.m
//  WresttApp
//
//  Created by  on 12/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

#import "WresttHomeViewController.h"
#import "WresttToolsViewController.h"
#import "WresttQuizViewController.h"
#import "WresttProfileViewController.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    self.tabBarController = [[UITabBarController alloc] init];
    WresttHomeViewController *homeViewController = [[WresttHomeViewController alloc] initWithNibName:@"WresttHomeViewController" bundle:nil];
    WresttToolsViewController *toolViewController = [[WresttToolsViewController alloc] initWithNibName:@"WresttToolsViewController" bundle:nil];
    UINavigationController *toolViewNavigationController = [[UINavigationController alloc] initWithRootViewController:toolViewController];
    WresttQuizViewController *quizViewController = [[WresttQuizViewController alloc] initWithNibName:@"WresttQuizViewController" bundle:nil];
    UINavigationController *quizViewNavigationController = [[UINavigationController alloc] initWithRootViewController:quizViewController];
    WresttProfileViewController *profileViewController = [[WresttProfileViewController alloc] initWithNibName:@"WresttProfileViewController" bundle:nil];
    
    self.tabBarController.viewControllers = [[NSArray alloc] initWithObjects: homeViewController, toolViewNavigationController, quizViewNavigationController, profileViewController, nil];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
