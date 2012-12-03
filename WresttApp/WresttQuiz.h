//
//  WresttQuiz.h
//  WresttApp
//
//  Created by Steven Berlanga on 12/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WresttQuiz : NSObject

@property (strong,nonatomic) NSString * toolName;
@property (strong,nonatomic) NSMutableArray * questions;
@property (strong,nonatomic) NSMutableArray * answers;

@end
