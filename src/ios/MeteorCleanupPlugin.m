#import "MeteorCleanupPlugin.h"

@implementation MeteorCleanupPlugin

- (CDVPlugin *)initWithWebView:(UIWebView *)theWebView {
    NSLog(@"Checking cordova version");
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];

    return self;
}

@end
