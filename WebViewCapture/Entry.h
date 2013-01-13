//
//  Entry.h
//  WebViewCapture
//
//  Created by Masaaki Takeuchi on 2013/01/13.
//  Copyright (c) 2013年 Masaaki Takeuchi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (strong) NSString *targetUrl;
@property (strong) NSString *outputPath;

- (id)init;
//- (id)initWithUrl:(NSString*)url outPath:(NSString*)path;

@end
