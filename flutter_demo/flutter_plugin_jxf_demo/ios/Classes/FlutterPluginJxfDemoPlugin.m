#import "FlutterPluginJxfDemoPlugin.h"
#if __has_include(<flutter_plugin_jxf_demo/flutter_plugin_jxf_demo-Swift.h>)
#import <flutter_plugin_jxf_demo/flutter_plugin_jxf_demo-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_plugin_jxf_demo-Swift.h"
#endif

@implementation FlutterPluginJxfDemoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPluginJxfDemoPlugin registerWithRegistrar:registrar];
}
@end
