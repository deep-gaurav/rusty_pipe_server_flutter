import Flutter
import UIKit

public class SwiftRustyPipeServerFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "rusty_pipe_server_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftRustyPipeServerFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
