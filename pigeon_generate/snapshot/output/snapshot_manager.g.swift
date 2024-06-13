// Autogenerated from Pigeon (v17.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct Size {
  /// Width of the size.
  var width: Double
  /// Height of the size.
  var height: Double

  static func fromList(_ list: [Any?]) -> Size? {
    let width = list[0] as! Double
    let height = list[1] as! Double

    return Size(
      width: width,
      height: height
    )
  }
  func toList() -> [Any?] {
    return [
      width,
      height,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct MapSnapshotOptions {
  var size: Size
  var pixelRatio: Double

  static func fromList(_ list: [Any?]) -> MapSnapshotOptions? {
    let size = Size.fromList(list[0] as! [Any?])!
    let pixelRatio = list[1] as! Double

    return MapSnapshotOptions(
      size: size,
      pixelRatio: pixelRatio
    )
  }
  func toList() -> [Any?] {
    return [
      size.toList(),
      pixelRatio,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct SnapshotOverlayOptions {
  var showLogo: Bool
  var showAttributes: Bool

  static func fromList(_ list: [Any?]) -> SnapshotOverlayOptions? {
    let showLogo = list[0] as! Bool
    let showAttributes = list[1] as! Bool

    return SnapshotOverlayOptions(
      showLogo: showLogo,
      showAttributes: showAttributes
    )
  }
  func toList() -> [Any?] {
    return [
      showLogo,
      showAttributes,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct MbxImage {
  /// The width of the image, in screen pixels.
  var width: Int64
  /// The height of the image, in screen pixels.
  var height: Int64
  /// 32-bit premultiplied RGBA image data.
  ///
  /// An uncompressed image data encoded in 32-bit RGBA format with premultiplied
  /// alpha channel. This field should contain exactly `4 * width * height` bytes. It
  /// should consist of a sequence of scanlines.
  var data: FlutterStandardTypedData

  static func fromList(_ list: [Any?]) -> MbxImage? {
    let width = list[0] is Int64 ? list[0] as! Int64 : Int64(list[0] as! Int32)
    let height = list[1] is Int64 ? list[1] as! Int64 : Int64(list[1] as! Int32)
    let data = list[2] as! FlutterStandardTypedData

    return MbxImage(
      width: width,
      height: height,
      data: data
    )
  }
  func toList() -> [Any?] {
    return [
      width,
      height,
      data,
    ]
  }
}

private class _SnapShotManagerCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 128:
      return MapSnapshotOptions.fromList(self.readValue() as! [Any?])
    case 129:
      return MbxImage.fromList(self.readValue() as! [Any?])
    case 130:
      return Size.fromList(self.readValue() as! [Any?])
    case 131:
      return SnapshotOverlayOptions.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class _SnapShotManagerCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? MapSnapshotOptions {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? MbxImage {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? Size {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? SnapshotOverlayOptions {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class _SnapShotManagerCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return _SnapShotManagerCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return _SnapShotManagerCodecWriter(data: data)
  }
}

class _SnapShotManagerCodec: FlutterStandardMessageCodec {
  static let shared = _SnapShotManagerCodec(readerWriter: _SnapShotManagerCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol _SnapShotManager {
  func create(options: MapSnapshotOptions, overlayOptions: SnapshotOverlayOptions) throws -> String
  func snapshot(completion: @escaping (Result<MbxImage?, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class _SnapShotManagerSetup {
  /// The codec used by _SnapShotManager.
  static var codec: FlutterStandardMessageCodec { _SnapShotManagerCodec.shared }
  /// Sets up an instance of `_SnapShotManager` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: _SnapShotManager?) {
    let createChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapShotManager.create", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      createChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let optionsArg = args[0] as! MapSnapshotOptions
        let overlayOptionsArg = args[1] as! SnapshotOverlayOptions
        do {
          let result = try api.create(options: optionsArg, overlayOptions: overlayOptionsArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      createChannel.setMessageHandler(nil)
    }
    let snapshotChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapShotManager.snapshot", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      snapshotChannel.setMessageHandler { _, reply in
        api.snapshot { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      snapshotChannel.setMessageHandler(nil)
    }
  }
}