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

@interface WresttDatabaseInterface : NSObject

@property (strong, nonatomic) WresttUser *currentUser;


+ (id)sharedDatabaseInterface;

- (BOOL)validateUser:(NSString *)userID password:(NSString *)pass;
- (NSMutableArray *)getQuizzes;
- (NSMutableArray *)getTools;


@end
