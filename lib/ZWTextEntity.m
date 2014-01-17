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
	return [self initWithRange:NSMakeRange(0, 0) type:ZWTextEntityTypeURL];
}

- (instancetype)initWithRange:(NSRange)range type:(ZWTextEntityType)type
{
	self = [super init];
	if (!self) return nil;
	
	_range = range;
	_type = type;
	
	return self;
}

@end
