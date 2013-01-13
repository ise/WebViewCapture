//
//  Entry.m
//  WebViewCapture
//
//  Created by Masaaki Takeuchi on 2013/01/13.
//  Copyright (c) 2013年 Masaaki Takeuchi. All rights reserved.
//

#import "Entry.h"

@implementation Entry
@synthesize targetUrl = _targetUrl;
@synthesize outputPath = _outputPath;
- (id)init
{
    self = [super init];
    return self;
}
/*
- (id)initWithUrl:(NSString*)url outputPath:(NSString*)path
{
    self = [super init];
    self.targetUrl = url;
    self.outputPath = path;
    return self;
}
*/
@end
