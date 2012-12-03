//
//  WresttToolsViewController.m
//  WresttApp
//
//  Created by Lion User on 29/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WresttToolsViewController.h"
#import "WresttDatabaseInterface.h"
#import "WresttToolsDetailViewController.h"
#import "WresttTool.h"

@interface WresttToolsViewController ()

@end

@implementation WresttToolsViewController

@synthesize databaseInterface =_databaseInterface, toolDetailViewController = _toolDetailViewController, tableView = _tableView, searchDisplayController = _toolSearchDisplayController, tableData = _tableData, searchResults = _searchResults;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        self.title = @"Tools";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _databaseInterface = [WresttDatabaseInterface sharedDatabaseInterface];

    self.tableData = [self.databaseInterface getTools];

    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;

    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        rows = [self.searchResults count];
    }
    else
    {
        rows = [self.tableData count];
    }

    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ToolCellIdentifier";
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    WresttTool *tool;
    
    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        tool = [self.searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        tool = [self.tableData objectAtIndex:indexPath.row];
    }

    cell.textLabel.text = tool.name;
    cell.detailTextLabel.text = tool.category;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.toolDetailViewController == nil)
    {
        _toolDetailViewController = [[WresttToolsDetailViewController alloc] initWithNibName:@"WresttToolsDetailViewController" bundle:nil];
    }
    
    [self.toolDetailViewController setTitle:[tableView cellForRowAtIndexPath:indexPath].textLabel.text];
    
    [self.navigationController pushViewController:self.toolDetailViewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UISearchDisplayController delegate methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:searchOption]];
    return YES;
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];

    self.searchResults = [self.tableData filteredArrayUsingPredicate:resultPredicate];
}

@end
