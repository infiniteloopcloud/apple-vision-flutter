#import "FlutterAppleVisionPlugin.h"
#if __has_include(<flutter_apple_vision/flutter_apple_vision-Swift.h>)
#import <flutter_apple_vision/flutter_apple_vision-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_apple_vision-Swift.h"
#endif

@implementation FlutterAppleVisionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterAppleVisionPlugin registerWithRegistrar:registrar];
}
@end
