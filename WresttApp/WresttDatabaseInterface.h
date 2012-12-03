//
//  WresttDatabaseInterface.h
//  WresttApp
//
//  Created by steven berlanga on 12/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WresttUser.h"
#import "WresttQuiz.h"
#import "WresttTool.h"
#import <sqlite3.h>

@interface WresttDatabaseInterface : NSObject{
    sqlite3 *database;
    NSString * primaryKey;
    NSString *text;
}

@property (nonatomic,readonly) NSString * primaryKey;
@property (nonatomic, retain) NSString * text;


+ (id)sharedDatabaseInterface;

-(BOOL) validateUser:(NSString *)userID password:(NSString *)pass;
-(WresttUser *) getUser:(NSString *)userID;
-(int) getToolCount;
-(int) getQuizCount;
-(NSMutableArray *) getQuizs;
-(NSMutableArray *) getTools;


@end
