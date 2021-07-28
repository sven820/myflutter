import Cocoa
import FlutterMacOS

public class FlutterPluginJxfDemoPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_plugin_jxf_demo", binaryMessenger: registrar.messenger)
    let instance = FlutterPluginJxfDemoPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    case "getBatteryLevel":
        result(0.5)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
