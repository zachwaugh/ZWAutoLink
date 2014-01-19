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
#import <AppKit/AppKit.h>

@interface ZWAutoLinkTests : XCTestCase

@end

@implementation ZWAutoLinkTests

- (void)testAutoLinkParsing
{
	NSArray *links = @[
										 @"http://www.rubyonrails.com",
										 @"http://www.rubyonrails.com:80",
										 @"http://www.rubyonrails.com/~minam",
										 @"https://www.rubyonrails.com/~minam",
										 @"http://www.rubyonrails.com/~minam/url%20with%20spaces",
										 @"http://www.rubyonrails.com/foo.cgi?something=here",
										 @"http://www.rubyonrails.com/foo.cgi?something=here&and=here",
										 @"http://www.rubyonrails.com/contact;new",
										 @"http://www.rubyonrails.com/contact;new%20with%20spaces",
										 @"http://www.rubyonrails.com/contact;new?with=query&string=params",
										 @"http://www.rubyonrails.com/~minam/contact;new?with=query&string=params",
										 @"http://en.wikipedia.org/wiki/Wikipedia:Today%27s_featured_picture_%28animation%29/January_20%2C_2007",
										 @"http://www.mail-archive.com/rails@lists.rubyonrails.org/",
										 @"http://www.amazon.com/Testing-Equal-Sign-In-Path/ref=pd_bbs_sr_1?ie=UTF8&s=books&qid=1198861734&sr=8-1",
										 @"http://en.wikipedia.org/wiki/Texas_hold'em",
										 @"https://www.google.com/doku.php?id=gps:resource:scs:start",
										 @"http://connect.oraclecorp.com/search?search[q]=green+france&search[type]=Group",
										 @"http://of.openfoundry.org/projects/492/download#4th.Release.3",
										 @"http://maps.google.co.uk/maps?f=q&q=the+london+eye&ie=UTF8&ll=51.503373,-0.11939&spn=0.007052,0.012767&z=16&iwloc=A",
										 @"http://около.кола/колокола"
										 ];
	
	for (NSString *link in links) {
		NSRange range = NSMakeRange(0, link.length);
		NSArray *entities = [ZWAutoLink URLsInText:link];
		ZWTextEntity *entity = entities[0];
		XCTAssertTrue(entities.count == 1);
		XCTAssertTrue(NSEqualRanges(entity.range, range));
		XCTAssertTrue([link zw_isLink]);
	}
}

- (void)testAutoLinkWithBrackets
{
	NSString *link;
	NSRange expected;
	NSArray *urls;
	ZWTextEntity *entity;
	
	link = @"(link: http://en.wikipedia.org/wiki/Sprite_(computer_graphics))";
	expected = NSMakeRange(7, 55);
	urls = [ZWAutoLink URLsInText:link];
	entity = urls[0];
	XCTAssertTrue(urls.count == 1);
	XCTAssertTrue(NSEqualRanges(entity.range, expected), @"Invalid range: %@", entity);
	
	link = @"[link: http://en.wikipedia.org/wiki/Sprite_[computer_graphics]]";
	expected = NSMakeRange(7, 55);
	urls = [ZWAutoLink URLsInText:link];
	entity = urls[0];
	XCTAssertTrue(urls.count == 1);
	XCTAssertTrue(NSEqualRanges(entity.range, expected), @"Invalid range: %@", entity);
	
	link = @"{link: http://en.wikipedia.org/wiki/Sprite_{computer_graphics}}";
	expected = NSMakeRange(7, 55);
	urls = [ZWAutoLink URLsInText:link];
	entity = urls[0];
	XCTAssertTrue(urls.count == 1);
	XCTAssertTrue(NSEqualRanges(entity.range, expected), @"Invalid range: %@", entity);
}

- (void)testAutoLinkOtherProtocols
{
	NSString *text = @"Download ftp://example.com/file.txt";
	NSRange range = NSMakeRange(@"Download ".length, 26);
	
	NSArray *entities = [ZWAutoLink URLsInText:text];
	ZWTextEntity *entity = entities[0];
	XCTAssertTrue(entities.count == 1);
	XCTAssertTrue(entity.type == ZWTextEntityTypeURL);
	XCTAssertTrue(NSEqualRanges(entity.range, range));
	
	text = @"file:///home/username/RomeoAndJuliet.pdf";
	range = NSMakeRange(0, text.length);
	entities = [ZWAutoLink URLsInText:text];
	entity = entities[0];
	XCTAssertTrue(entities.count == 1);
	XCTAssertTrue(entity.type == ZWTextEntityTypeURL);
	XCTAssertTrue(NSEqualRanges(entity.range, range));
}

- (void)testAutoLinkWithMultipleTrailingPunctuations
{
	NSString *link = @"(link: http://youtube.com).";
	NSArray *entities = [ZWAutoLink URLsInText:link];
	NSRange range = NSMakeRange(7, 18);
	ZWTextEntity *entity = entities[0];
	XCTAssertTrue(entities.count == 1);
	XCTAssertTrue(NSEqualRanges(entity.range, range), @"Invalid range: %@", entity);
}

@end
