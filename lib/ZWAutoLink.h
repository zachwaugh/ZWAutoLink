//
//  ZWAutoLink.h
//  ZWAutoLink
//
//  Created by Zach Waugh on 1/17/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWAutoLink : NSObject

+ (NSArray *)URLsInText:(NSString *)text;
+ (NSArray *)URLsInText:(NSString *)text options:(NSDictionary *)options;

@end
