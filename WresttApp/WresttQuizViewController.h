//
//  WresttQuizViewController.h
//  WresttApp
//
//  Created by Lion User on 29/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WresttDatabaseInterface;
@class WresttTakeQuizViewController;

@interface WresttQuizViewController : UIViewController

@property (strong, nonatomic) WresttDatabaseInterface *databaseInterface;
@property (strong, nonatomic) WresttTakeQuizViewController *takeQuizViewController;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplayController;

@property (strong, nonatomic) NSArray *tableData;
@property (strong, nonatomic) NSArray *searchResults;

@end
