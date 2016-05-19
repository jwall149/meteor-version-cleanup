#import "MeteorCleanupPlugin.h"

@implementation MeteorCleanupPlugin

- (void)pluginInitialize {
    NSLog(@"Checking cordova version");
    NSString* version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString* key = [NSString stringWithFormat:@"esportsplus_mcp_version_mark_%@", version];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

    id settingsValue = [defaults objectForKey:key];

    if (settingsValue == nil) {
        NSLog(@"This version %@ is first time install/downloaded, remove meteor current version...", version);

        NSString* libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
        NSString* meteorVersionPath = [libPath stringByAppendingPathComponent:@"NoCloud/meteor/version"];

        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL hasMeteorVersion = [fileManager fileExistsAtPath:meteorVersionPath];
        NSError* error;
        if (hasMeteorVersion) {
            [fileManager removeItemAtPath:meteorVersionPath error:&error];
        }
        if (!error) {
            [defaults setValue:@"marked" forKey:key];
            [defaults synchronize];
        }
    }

}

@end
