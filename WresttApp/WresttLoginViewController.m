//
//  WresttViewController.m
//  WresttApp
//
//  Created by Lion User on 29/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WresttLoginViewController.h"
#import "DejalActivityView.h"

@interface WresttLoginViewController ()

@end

@implementation WresttLoginViewController

@synthesize userName = _userName, password = _password, login = _login;

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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
    [self setUserName:nil];
    [self setPassword:nil];
    [self setLogin:nil];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)login:(id)sender
{
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Login in..." width:150].showNetworkActivityIndicator = YES;
    //Authenitcate user
    [self performSelector:@selector(dismissSelf) withObject:nil afterDelay:1.5];
}

- (void)dismissSelf
{
    [DejalActivityView removeView];
    [self dismissModalViewControllerAnimated:YES];
}

@end
