import Flutter
import UIKit
import Vision

public class SwiftFlutterAppleVisionPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "flutter_apple_vision", binaryMessenger: registrar.messenger())
        let instance = SwiftFlutterAppleVisionPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if (call.method == "recognizeText") {
            recognizeText(call, result)
        }
    }
    
    private func recognizeText(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
        let uintInt8List =  call.arguments as! FlutterStandardTypedData
        let byte = [UInt8](uintInt8List.data)
        
        let requestHandler = VNImageRequestHandler(data: Data(byte))
        
        if #available(iOS 13.0, *) {
            let request = VNRecognizeTextRequest { request, error in
                if let error = error {
                    result(error.localizedDescription)
                } else {
                    let textList = request.results.map { observations in
                        observations.map { observation in
                            var data = [:]
                            
                            if let rect = observation.value(forKey: "boundingBox") as? CGRect {
                                data["rect"] = [
                                    rect.minX,
                                    rect.minY,
                                    rect.maxX,
                                    rect.maxY
                                ];
                            }
                            
                            if let observation = observation as? VNRecognizedTextObservation {
                                data["textOptions"] =  observation.topCandidates(10).map {  text in
                                    text.string
                                }
                            }
                            
                            return data
                        }
                    }
                    
                    result(textList)
                }
            }
            
            do {
                try requestHandler.perform([request])
            } catch {
                result([["error": "Unable to perform the requests: \(error)."]])
            }
        } else {
            result([])
        }
    }
}
