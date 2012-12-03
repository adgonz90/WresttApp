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

@synthesize primaryKey,text;

+ (id)sharedDatabaseInterface
{
    @synchronized(self)
    {
        if (dbInterface == nil)
            dbInterface = [[self alloc] init];
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
    
    if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
    {
        NSAssert(0,@"Failed %s",sqlite3_errmsg(database));
    }
    
    if(sqlite3_step(init_statement) == SQLITE_ROW)
    {
        return YES;
    }

    return NO;
}

-(NSString *)getUser:(NSString *)userID
{
    NSString * sqlString = [NSString stringWithFormat:@"Select * from users"];
    const char *sql = [sqlString UTF8String];
    
    if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
    {
        NSAssert(0,@"Failed %s",sqlite3_errmsg(database));
    }
    
    if(sqlite3_step(init_statement) == SQLITE_ROW)
    {
        self.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(init_statement, 0)];
    }
    else
    {
        NSLog(@"Failed %s",sqlite3_errmsg(database));
        self.text = @"Error";
    }
    
    return text;
}

- (int)getToolCount
{
    NSString * sqlString = [NSString stringWithFormat:@"Select * from tools"];
    const char *sql = [sqlString UTF8String];
    
    if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
    {
        NSAssert(0,@"Failed %s",sqlite3_errmsg(database));
    }
    
    int count = 0;
    
    while(sqlite3_step(init_statement) == SQLITE_ROW)
    {
        count++;
    }

    return count;
}

- (int)getQuizCount
{
    NSString * sqlString = [NSString stringWithFormat:@"Select * from quiz"];
    const char *sql = [sqlString UTF8String];
    
    if(sqlite3_prepare_v2(database, sql, -1, &init_statement, NULL) != SQLITE_OK)
    {
        NSAssert(0,@"Failed %s",sqlite3_errmsg(database));
    }

    int count = 0;
         
    while(sqlite3_step(init_statement) == SQLITE_ROW)
    {
        count++;
    }

    return count;
}

-(NSArray *) getTools
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

-(NSArray *) getQuizs{

    NSString * sqlString = [NSString stringWithFormat:@"Select * from quiz"];
    
    if(sqlite3_prepare_v2(database, [sqlString UTF8String], -1, &init_statement, NULL) != SQLITE_OK)
    {
        NSAssert(0,@"Failed %s",sqlite3_errmsg(database));
    }

    NSMutableArray * arr = [[NSMutableArray alloc] init];

    while (sqlite3_step(init_statement) == SQLITE_ROW)
    {
        WresttQuiz *quiz = [[WresttQuiz alloc] init];
        
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