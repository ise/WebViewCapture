//
//  AppDelegate.h
//  WebViewCapture
//
//  Created by Masaaki Takeuchi on 2013/01/12.
//  Copyright (c) 2013年 Masaaki Takeuchi. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (strong) IBOutlet WebView *webView;

@end
