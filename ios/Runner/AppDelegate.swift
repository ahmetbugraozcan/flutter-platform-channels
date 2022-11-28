import UIKit
import Flutter
import Network

class MyCatApi: NSObject, CatApi {
  func getCats() -> [Cat?] {
    let tom = Cat(name: "Tom", age: 3)
    let jerry = Cat(name: "Jerry", age: 2)
    return [ tom, jerry ]
  }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
    let deviceModelChannel = FlutterMethodChannel(name: "com.example.native_channel_example/device",
                                                    binaryMessenger: controller.binaryMessenger)
      deviceModelChannel.setMethodCallHandler({
           (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          guard call.method == "getDeviceNameFromNative" else {
             result(FlutterMethodNotImplemented)
             return
           }
          
          result(String(UIDevice().name))
          
      })
      
      
      let eventChannel = FlutterEventChannel(name: "com.example.native_channel_example/wifi", binaryMessenger: controller.binaryMessenger)
      eventChannel.setStreamHandler(SwiftStreamHandler())
       let api = MyCatApi()

      CatApiSetup.setUp(binaryMessenger: controller.binaryMessenger, api: api)
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class SwiftStreamHandler: NSObject, FlutterStreamHandler {
  
        let networkMonitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        override init() {
            networkMonitor.start(queue: queue)
        }
        
        
        public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
            
            networkMonitor.pathUpdateHandler = { path in
                    events(String(describing: path.status))
            }
            
            return nil
        }
        
        public func onCancel(withArguments arguments: Any?) -> FlutterError? {
            return nil
        }
    }
