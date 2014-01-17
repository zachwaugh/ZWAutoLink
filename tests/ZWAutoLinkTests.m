//
//  ZWAutoLinkTests.m
//  ZWAutoLinkTests
//
//  Created by Zach Waugh on 1/17/14.
//  Copyright (c) 2014 Zach Waugh. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ZWAutoLink.h"
#import "ZWTextEntity.h"

@interface ZWAutoLinkTests : XCTestCase

@end

@implementation ZWAutoLinkTests

- (void)testAutoLink
{
	
}

- (void)testAutoLinkWithBrackets
{
	NSString *link;
	NSRange expected;
	NSArray *urls;
	ZWTextEntity *entity;
	
	link = @"http://en.wikipedia.org/wiki/Sprite_(computer_graphics)";
	expected = NSMakeRange(0, link.length);
	urls = [ZWAutoLink URLsInText:link];
	entity = urls[0];
	XCTAssertTrue(urls.count == 1);
	XCTAssertTrue(NSEqualRanges(entity.range, expected));
	
	
	link = @"http://en.wikipedia.org/wiki/Sprite_[computer_graphics]";
	expected = NSMakeRange(0, link.length);
	urls = [ZWAutoLink URLsInText:link];
	entity = urls[0];
	XCTAssertTrue(urls.count == 1);
	XCTAssertTrue(NSEqualRanges(entity.range, expected));
	
	
	link = @"http://en.wikipedia.org/wiki/Sprite_{computer_graphics}";
	expected = NSMakeRange(0, link.length);
	urls = [ZWAutoLink URLsInText:link];
	entity = urls[0];
	XCTAssertTrue(urls.count == 1);
	XCTAssertTrue(NSEqualRanges(entity.range, expected));
}


- (void)testAutoLinkOtherProtocols
{
	NSString *ftpRaw = @"Download ftp://example.com/file.txt";
	NSRange range = NSMakeRange(@"Download ".length, 26);
	
	NSArray *entities = [ZWAutoLink URLsInText:ftpRaw];
	ZWTextEntity *entity = entities[0];
	XCTAssertTrue(entities.count == 1);
	XCTAssertTrue(entity.type == ZWTextEntityTypeURL);
	XCTAssertTrue(NSEqualRanges(entity.range, range));
	
//	file_scheme = 'file:///home/username/RomeoAndJuliet.pdf'

}


@end
