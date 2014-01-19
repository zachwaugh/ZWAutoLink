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

@implementation NSString (ZWAutoLink)

- (BOOL)zw_isLink
{
	NSArray *entities = [ZWAutoLink URLsInText:self];
	return entities.count == 1 && NSEqualRanges([entities[0] range], NSMakeRange(0, self.length));
}

@end

@implementation ZWAutoLink

+ (NSArray *)URLsInText:(NSString *)text
{
	return [self URLsInText:text options:nil];
}

+ (NSArray *)URLsInText:(NSString *)text options:(NSDictionary *)options
{
	NSRegularExpression *regex = [self autoLinkRegex];
	NSArray *matches = [regex matchesInString:text options:0 range:NSMakeRange(0, text.length)];

	NSRegularExpression *r = [NSRegularExpression regularExpressionWithPattern:@"[^\\p{Word}\\/-]$" options:0 error:nil];
	NSDictionary *brackets = @{ @"]": @"[", @")": @"(", @"}": @"{" };
	
	NSMutableArray *entities = [[NSMutableArray alloc] init];
	for (NSTextCheckingResult *match in matches) {
		NSRange range = match.range;
		NSMutableString *link = [[NSMutableString alloc] initWithString:[text substringWithRange:range]];
		NSTextCheckingResult *match = nil;
		
		do {
			match = [r firstMatchInString:link options:0 range:NSMakeRange(0, link.length)];
			if (match) {
				NSString *p = [link substringWithRange:match.range];
				[link deleteCharactersInRange:match.range];
				range.length--;
				NSString *opening = brackets[p];
				
				if (opening) {
					NSUInteger openingMatches = [self numberOfMatchesOfString:opening inString:link];
					NSUInteger closingMatches = [self numberOfMatchesOfString:p inString:link];
										
					if (openingMatches > closingMatches) {
						[link appendString:p];
						range.length++;
						break;
					}
				}
			}
		} while (match != nil);
		
		ZWTextEntity *entity = [[ZWTextEntity alloc] initWithRange:range text:link type:ZWTextEntityTypeURL];
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

#pragma mark - Private helpers

+ (NSUInteger)numberOfMatchesOfString:(NSString *)needle inString:(NSString *)haystack
{
	NSUInteger count = 0, length = haystack.length;
	NSRange range = NSMakeRange(0, length);
	while (range.location != NSNotFound) {
	  range = [haystack rangeOfString:needle options:0 range:range];
	  if (range.location != NSNotFound) {
	    range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
	    count++;
	  }
	}
	
	return count;
}

@end
