//
//  ZWAutoLink.m
//  ZWAutoLink
//
//  Created by Zach Waugh on 1/17/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

#import "ZWAutoLink.h"
#import "ZWTextEntity.h"

#define REGEX @"(?:((?:ed2k|ftp|http|https|irc|mailto|news|gopher|nntp|telnet|webcal|xmpp|callto|feed|svn|urn|aim|rsync|tag|ssh|sftp|rtsp|afs|file):)//|www\\.)[^\\s<\u00A0]+"

@implementation ZWAutoLink

+ (NSArray *)URLsInText:(NSString *)text
{
	return [self URLsInText:text options:nil];
}

+ (NSArray *)URLsInText:(NSString *)text options:(NSDictionary *)options
{
	NSRegularExpression *regex = [self autoLinkRegex];
	NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];
		
	NSMutableArray *entities = [[NSMutableArray alloc] init];
	for (NSTextCheckingResult *match in matches) {
		ZWTextEntity *entity = [[ZWTextEntity alloc] initWithRange:match.range type:ZWTextEntityTypeURL];
		[entities addObject:entity];
	}
	
	return entities;
}
										
#pragma mark - Regex
										
+ (NSRegularExpression *)autoLinkRegex
{
	static NSRegularExpression *regex = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		NSError *error = nil;
    regex = [[NSRegularExpression alloc] initWithPattern:REGEX options:0 error:&error];
	});
	
	return regex;
}

@end
