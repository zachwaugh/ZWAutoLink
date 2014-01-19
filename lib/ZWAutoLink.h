//
//  ZWAutoLink.h
//  ZWAutoLink
//
//  Created by Zach Waugh on 1/17/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZWAutoLink)

// Returns true if the entire string is a single link
- (BOOL)zw_isLink;

@end

@interface ZWAutoLink : NSObject

// Returns an array of ZWTextEntity objects found in `text`
+ (NSArray *)URLsInText:(NSString *)text;

// Returns an array of ZWTextEntity objects found in `text`, using `options` to modify how links are found
+ (NSArray *)URLsInText:(NSString *)text options:(NSDictionary *)options;

@end
