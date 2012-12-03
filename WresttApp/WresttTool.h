//
//  WresttTool.h
//  WresttApp
//
//  Created by Steven Berlanga on 12/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WresttTool : NSObject

@property (strong,nonatomic) NSString *name;
@property (strong,nonatomic) NSString *category;
@property (strong,nonatomic) NSString *description;
@property (strong,nonatomic) NSString *videoURL;
@property (assign, nonatomic) int quizID;

@end
