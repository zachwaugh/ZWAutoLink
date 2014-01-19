//
//  ZWTextEntity.m
//  ZWAutoLink
//
//  Created by Zach Waugh on 1/17/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

#import "ZWTextEntity.h"

@implementation ZWTextEntity

- (id)init
{
	return [self initWithRange:NSMakeRange(0, 0) text:@"" type:ZWTextEntityTypeURL];
}

- (instancetype)initWithRange:(NSRange)range text:(NSString *)text type:(ZWTextEntityType)type
{
	self = [super init];
	if (!self) return nil;
	
	_range = range;
	_type = type;
	_text = text;
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"<%@:%p> text: %@, range: %@, type: %lu", NSStringFromClass(self.class), self, self.text, NSStringFromRange(self.range), self.type];
}

@end
