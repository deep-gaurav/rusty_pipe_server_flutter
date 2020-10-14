#import "RustyPipeServerFlutterPlugin.h"
#if __has_include(<rusty_pipe_server_flutter/rusty_pipe_server_flutter-Swift.h>)
#import <rusty_pipe_server_flutter/rusty_pipe_server_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "rusty_pipe_server_flutter-Swift.h"
#endif

@implementation RustyPipeServerFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftRustyPipeServerFlutterPlugin registerWithRegistrar:registrar];
}
@end
