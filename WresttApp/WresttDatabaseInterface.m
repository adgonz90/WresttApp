//
//  WresttDatabaseInterface.m
//  WresttApp
//
//  Created by steven berlanga on 12/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WresttDatabaseInterface.h"

static sqlite3_stmt *init_statement = nil;
static WresttDatabaseInterface *dbInterface = nil;

@implementation WresttDatabaseInterface
{
    sqlite3 *database;
}

@synthesize currentUser;

+ (id)sharedDatabaseInterface
{
    @synchronized(self)
    {
        if (dbInterface == nil)
        {
            dbInterface = [[self alloc] init];
        }
    }
    return dbInterface;
}

- (id)init
{
    if(self = [super init])
    {
        NSString * path = [NSString stringWithFormat:@"%@/wrestt.sqllite",[[NSBundle mainBundle] resourcePath]];
        NSLog(@"%@",path);

        if(!(sqlite3_open([path UTF8String], &database) == SQLITE_OK))
        {
            NSLog(@"An error has occured opening Sqlite");
            return FALSE;
        }
    }
    return self;
}

- (BOOL)validateUser:(NSString *)userID password:(NSString *)pass
{
    NSString * sqlString = [NSString stringWithFormat:@"Select * from users where uid = '%@' and pass = '%@'",userID,pass];
    const char *sql = [sqlString UTF8String];

    currentUser = nil;

    if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
    {
        NSAssert(0,@"Failed %s",sqlite3_errmsg(database));
    }
    
    if(sqlite3_step(init_statement) == SQLITE_ROW)
    {
        WresttUser *user = [[WresttUser alloc] init];
        user.firstName = @"Hello";
        user.lastName = @"World";
        user.email = @"HelloWorld1@fiu.edu";
        user.picture = @"Test.jpeg";

        currentUser = user;
    }

    return !(currentUser == nil);
}

-(NSArray *)getTools
{
    NSString * sqlString = [NSString stringWithFormat:@"Select * from tools"];
    const char *sql = [sqlString UTF8String];

    if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
    {
        NSAssert(0,@"Failed %s",sqlite3_errmsg(database));
    }

    NSMutableArray * arr = [[NSMutableArray alloc] init];
    
    while(sqlite3_step(init_statement) == SQLITE_ROW)
    {
        WresttTool *tool = [[WresttTool alloc] init];
        
        tool.name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
        tool.category = @"Tool";//[NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
        tool.description =[NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 2)];
        tool.videoURL = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 3)];
        tool.quizID = sqlite3_column_int(init_statement, 4);

        [arr addObject:tool];
    }
    
    return  [NSArray arrayWithArray:arr];
}

-(NSArray *)getQuizzes
{
    NSString * sqlString = [NSString stringWithFormat:@"Select * from quiz"];
    
    if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &init_statement, NULL) != SQLITE_OK)
    {
        NSAssert(0,@"Failed %s",sqlite3_errmsg(database));
    }

    NSMutableArray * arr = [[NSMutableArray alloc] init];

    while (sqlite3_step(init_statement) == SQLITE_ROW)
    {
        WresttQuiz *quiz = [[WresttQuiz alloc] init];

        quiz.name = @"Quiz Name";

        [quiz.questions addObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)]];
        NSString * string = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 1)];
        [quiz.answers addObject:[string componentsSeparatedByString:@"-"]];

        [quiz.questions addObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 2)]];
        string = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 3)];
        [quiz.answers addObject:[string componentsSeparatedByString:@"-"]];

        [quiz.questions addObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 4)]];
        string = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 5)];
        [quiz.answers addObject:[string componentsSeparatedByString:@"-"]];

        [quiz.questions addObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 6)]];
        string = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 7)];
        [quiz.answers addObject:[string componentsSeparatedByString:@"-"]];

        [quiz.questions addObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 8)]];
        string = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 9)];
        [quiz.answers addObject:[string componentsSeparatedByString:@"-"]];

        [quiz.questions addObject: [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 10)]];
        string = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 11)];
        [quiz.answers addObject:[string componentsSeparatedByString:@"-"]];

        [arr addObject:quiz];
    }

    return  [NSArray arrayWithArray:arr];
}

@end