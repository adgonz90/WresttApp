//
//  WresttHomeViewController.m
//  WresttApp
//
//  Created by  on 12/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WresttHomeViewController.h"
#import "WresttLoginViewController.h"

@interface WresttHomeViewController ()

@end

@implementation WresttHomeViewController

BOOL loggedIn = NO;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Home";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    if (!loggedIn)// not logged in
    {
        WresttLoginViewController *loginViewController = [[WresttLoginViewController alloc] initWithNibName:@"WresttLoginViewController" bundle:nil];
        [self.tabBarController presentModalViewController:loginViewController animated:YES];

        loggedIn = YES;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
