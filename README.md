## ZWAutoLink

Objective-C library for auto-linking URLs in text, initially ported from the Rails [auto_link gem](https://github.com/tenderlove/rails_autolink) because I couldn't find an Objective-C library that covered all cases. The API was inspired by the [twitter-text-objc](https://github.com/twitter/twitter-text-objc) library. The API may change until version 1.0.

### Usage

```objc

// Returns an array of ZWTextEntity objects representing urls in the text
NSString *text = @"http://github.com";
NSArray *urls = [ZWAutoLink URLsInText:text];
ZWTextEntity *entity = urls[0];
NSLog(@"entity: %@", entity);
// entity: <ZWTextEntity:0x1005bbd40> text: http://github.com, range: {0, 17}, type: url

```

From the entities returned, you might create a `NSAttributedString` with links colored blue:

```objc

NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
for (ZWTextEntity *entity in urls) {
  [string addAttribute:NSLinkAttributeName value:[NSURL URLWithString:entity.text] range:entity.range];
  [string addAttribute:NSForegroundColorAttributeName value:[NSColor blueColor] range:entity.range];
}
```


### Why not use X?

`NSDataDetector` is a good built-in solution, but I found it didn't handle all the cases I needed and there was no configuration available. This has slightly different use cases, but the *rails_autolink* gem seemed like good place to start from a well-tested and widely used approach as opposed to writing my own regex. I plan on adding support for swapping out which "engine" to use, so you can auto-link with the NSDataDetector or your own regex if you prefer, re-use the same 

## To Do

- Add more tests
- Support linking emails
- Add support for truncation

## License

Licensed under the MIT license.

Copyright (c) 2014 Zach Waugh

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
