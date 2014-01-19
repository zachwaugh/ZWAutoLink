//
//  ZWTextEntity.h
//  ZWAutoLink
//
//  Created by Zach Waugh on 1/17/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, ZWTextEntityType) {
	ZWTextEntityTypeURL = 0,
	ZWTextEntityTypeEmail
};

@interface ZWTextEntity : NSObject

@property (nonatomic, assign, readonly) NSRange range;
@property (nonatomic, assign, readonly) ZWTextEntityType type;
@property (nonatomic, copy, readonly) NSString *text;

- (instancetype)initWithRange:(NSRange)range text:(NSString *)text type:(ZWTextEntityType)type;

@end
