//
//  ZWTextEntity.m
//  ZWAutoLink
//
//  Created by Zach Waugh on 1/17/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

#import "ZWTextEntity.h"

static NSString * ZWTextEntityStringForType(ZWTextEntityType type)
{
	switch (type) {
		case ZWTextEntityTypeEmail:
			return @"email";
			break;
		case ZWTextEntityTypeURL:
			return @"url";
		default:
			return @"uknown type";
			break;
	}
}

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
	return [NSString stringWithFormat:@"<%@:%p> text: %@, range: %@, type: %@", NSStringFromClass(self.class), self, self.text, NSStringFromRange(self.range), ZWTextEntityStringForType(self.type)];
}

@end
