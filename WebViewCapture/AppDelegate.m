//
//  AppDelegate.m
//  WebViewCapture
//
//  Created by Masaaki Takeuchi on 2013/01/12.
//  Copyright (c) 2013年 Masaaki Takeuchi. All rights reserved.
//

#import "AppDelegate.h"
#import "Entry.h"

@implementation AppDelegate

@synthesize webView = _webView;
Entry *_currentEntry;
NSMutableArray *_entries;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    //ファイル読み込み（パスは固定）
    _entries = [self _getEntries];
    //1URL処理
    [self _dequeueAndCapture];
}

- (NSMutableArray*)_getEntries
{
    NSMutableArray *entries = [[NSMutableArray alloc] init];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDesktopDirectory, NSUserDomainMask, YES);
    NSString *path = [NSString stringWithFormat:@"%@/urls.tsv", [paths objectAtIndex:0]];
    NSError *err;
    NSString *contents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&err];
    NSArray *lines = [contents componentsSeparatedByString:@"\n"];
    for (NSString *line in lines) {
        if ([line isEqualToString:@""]) {
            continue;
        }
        NSArray *data = [line componentsSeparatedByString:@"\t"];
        Entry *e = [[Entry alloc] init];
        e.targetUrl = [data objectAtIndex:0];
        e.outputPath = [data objectAtIndex:1];
        //Entry *e = [[Entry alloc] initWithUrl:[data objectAtIndex:0] outPath:[data objectAtIndex:1]];
        [entries addObject:e];
    }
    return entries;
}

- (void)_dequeueAndCapture
{
    NSLog(@"Dequeuing ... ");
    if (_entries.count <= 0) {
        NSLog(@"Entries is empty");
        return;
    }
    Entry *e = [_entries objectAtIndex:0];
    [_entries removeObjectAtIndex:0];
    [self _loadEntry:e];
}

- (void)_loadEntry:(Entry *)entry
{
    _currentEntry = entry;
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:entry.targetUrl]];
    [self.webView setFrameLoadDelegate:self];
    WebFrame *frame = [self.webView mainFrame];
    [frame loadRequest:req];
    NSLog(@"Loading request ... ");
}

- (void)webView:(WebView *)sender didFinishLoadForFrame:(WebFrame *)frame {
    if ([sender mainFrame] == frame) {
        NSLog(@"didFinishLoadForFrame");
        [self _saveCaptureImage:sender];
        
        //保存が完了したらdequeue
        [self _dequeueAndCapture];
    }
}

- (void)_saveCaptureImage:(WebView *)view
{
    [NSThread sleepForTimeInterval:5.0];
    NSView *target = [[[view mainFrame] frameView] documentView];
    NSBitmapImageRep *bitmap = [target bitmapImageRepForCachingDisplayInRect:[target bounds]];
    [target cacheDisplayInRect:[target bounds] toBitmapImageRep:bitmap];
    NSData *outData = [bitmap representationUsingType:NSPNGFileType properties:[NSDictionary dictionary]];
    NSLog(@"Writing capture image: %@ => %@", _currentEntry.targetUrl, _currentEntry.outputPath);
    [outData writeToFile:_currentEntry.outputPath atomically:YES];
}

@end
