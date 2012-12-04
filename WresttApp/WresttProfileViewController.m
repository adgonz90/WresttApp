//
//  WresttProfileViewController.m
//  WresttApp
//
//  Created by Lion User on 29/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WresttProfileViewController.h"
#import "WresttDatabaseInterface.h"
#import "WresttUser.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface WresttProfileViewController ()

@end

@implementation WresttProfileViewController

@synthesize databaseInterface = _databaseInterface, user = _user, profilePicture = _profilePicture, firstName = _firstName, lastName = _lastName, email = _email;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Profile";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _databaseInterface = [WresttDatabaseInterface sharedDatabaseInterface];
    
    self.profilePicture.image = [UIImage imageNamed:@"defaultProfilePicture.png"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    self.user = self.databaseInterface.currentUser;
    if (self.user)
    {
        self.title = [NSString stringWithFormat:@"%@'s Profile", self.user.firstName];
        //set all the view fields
    }
    else
    {
        NSLog(@"No User Logged In!");
    }
}

- (IBAction)takeProfilePicture
{
    [self startCameraControllerFromViewController:self usingDelegate:self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller
                                   usingDelegate: (id <UIImagePickerControllerDelegate, UINavigationControllerDelegate>) delegate
{
    // Does hardware support a camera
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    // Create the picker object
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    // Specify the types of camera features available
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    // Displays a control that allows the user to take pictures only.    
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];  
    
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    // Specify which object contains the picker's methods
    cameraUI.delegate = delegate;
    
    // Picker object view is attached to view hierarchy and displayed.
    [controller presentViewController: cameraUI animated: YES completion: nil ];
    return YES;
}

#pragma mark - Camera Delegate Methods 

// For responding to the user tapping Cancel.
- (void) imagePickerControllerDidCancel: (UIImagePickerController *) picker
{
    [self dismissViewControllerAnimated: YES completion: nil];
}

// For responding to the user accepting a newly-captured picture 
// Picker passes a NSDictionary with acquired camera data
- (void) imagePickerController: (UIImagePickerController *) picker didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    // Create an image and store the acquired picture
    UIImage  *imageToSave;
    imageToSave = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Save the new image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum(imageToSave, nil, nil , nil);
    
    // View the image on screen 
    self.profilePicture.image = imageToSave;
    
    // Tell controller to remove the picker from the view hierarchy and release object.
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
