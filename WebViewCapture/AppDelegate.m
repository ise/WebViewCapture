//
//  AppDelegate.m
//  WebViewCapture
//
//  Created by Masaaki Takeuchi on 2013/01/12.
//  Copyright (c) 2013年 Masaaki Takeuchi. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize webView = _webView;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSURL *url = [NSURL URLWithString:@"http://www.cdinaba.com/"];
    NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [self.webView setFrameLoadDelegate:self];
    WebFrame *frame = [self.webView mainFrame];
    [frame loadRequest:req];
}

- (void) webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    if ([sender mainFrame] == frame) {
        NSLog(@"didFinishLoadForFrame");
        [self _saveCaptureImage:sender];
    }
}

- (void)_saveCaptureImage:(WebView *)view
{
    NSView *target = [[[view mainFrame] frameView] documentView];
    NSBitmapImageRep *bitmap = [target bitmapImageRepForCachingDisplayInRect:[target bounds]];
    [target cacheDisplayInRect:[target bounds] toBitmapImageRep:bitmap];
    NSData *outData = [bitmap representationUsingType:NSPNGFileType properties:[NSDictionary dictionary]];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/a.png", [paths objectAtIndex:0]];
    [outData writeToFile:path atomically:YES];
}

@end
