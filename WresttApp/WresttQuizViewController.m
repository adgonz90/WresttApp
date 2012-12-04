//
//  WresttQuizViewController.m
//  WresttApp
//
//  Created by Lion User on 29/11/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WresttQuizViewController.h"
#import "WresttDatabaseInterface.h"
#import "WresttTakeQuizViewController.h"
#import "WresttQuiz.h"

@interface WresttQuizViewController ()

@end

@implementation WresttQuizViewController

@synthesize databaseInterface =_databaseInterface, takeQuizViewController = _takeQuizViewController, tableView = _tableView, searchDisplayController = _quizSearchDisplayController, tableData = _tableData, searchResults = _searchResults;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Quizzes";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _databaseInterface = [WresttDatabaseInterface sharedDatabaseInterface];

    self.tableData = [self.databaseInterface getQuizzes];

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
    static NSString *CellIdentifier = @"QuizCellIdentifier";

    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    WresttQuiz *quiz;

    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        quiz = [self.searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        quiz = [self.tableData objectAtIndex:indexPath.row];
    }

    cell.textLabel.text = quiz.name;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.takeQuizViewController == nil)
    {
        _takeQuizViewController = [[WresttTakeQuizViewController alloc] initWithNibName:@"WresttTakeQuizViewController" bundle:nil];
    }

    WresttQuiz *quiz;

    if ([tableView isEqual:self.searchDisplayController.searchResultsTableView])
    {
        quiz = [self.searchResults objectAtIndex:indexPath.row];
    }
    else
    {
        quiz = [self.tableData objectAtIndex:indexPath.row];
    }
    
    self.takeQuizViewController.quiz = quiz;
    [self.navigationController pushViewController:self.takeQuizViewController animated:YES];

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
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[cd] %@", searchText];

    self.searchResults = [self.tableData filteredArrayUsingPredicate:resultPredicate];
}

@end
