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

private func createConnectionError(withChannelName channelName: String) -> FlutterError {
  return FlutterError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct MbxEdgeInsets {
  /// Padding from the top.
  var top: Double
  /// Padding from the left.
  var left: Double
  /// Padding from the bottom.
  var bottom: Double
  /// Padding from the right.
  var right: Double

  static func fromList(_ list: [Any?]) -> MbxEdgeInsets? {
    let top = list[0] as! Double
    let left = list[1] as! Double
    let bottom = list[2] as! Double
    let right = list[3] as! Double

    return MbxEdgeInsets(
      top: top,
      left: left,
      bottom: bottom,
      right: right
    )
  }
  func toList() -> [Any?] {
    return [
      top,
      left,
      bottom,
      right,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct ScreenCoordinate {
  /// A value representing the x position of this coordinate.
  var x: Double
  /// A value representing the y position of this coordinate.
  var y: Double

  static func fromList(_ list: [Any?]) -> ScreenCoordinate? {
    let x = list[0] as! Double
    let y = list[1] as! Double

    return ScreenCoordinate(
      x: x,
      y: y
    )
  }
  func toList() -> [Any?] {
    return [
      x,
      y,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct CameraOptions {
  /// Coordinate at the center of the camera.
  var center: [String?: Any?]? = nil
  /// Padding around the interior of the view that affects the frame of
  /// reference for `center`.
  var padding: MbxEdgeInsets? = nil
  /// Point of reference for `zoom` and `angle`, assuming an origin at the
  /// top-left corner of the view.
  var anchor: ScreenCoordinate? = nil
  /// Zero-based zoom level. Constrained to the minimum and maximum zoom
  /// levels.
  var zoom: Double? = nil
  /// Bearing, measured in degrees from true north. Wrapped to [0, 360).
  var bearing: Double? = nil
  /// Pitch toward the horizon measured in degrees.
  var pitch: Double? = nil

  static func fromList(_ list: [Any?]) -> CameraOptions? {
    let center: [String?: Any?]? = nilOrValue(list[0])
    var padding: MbxEdgeInsets? = nil
    if let paddingList: [Any?] = nilOrValue(list[1]) {
      padding = MbxEdgeInsets.fromList(paddingList)
    }
    var anchor: ScreenCoordinate? = nil
    if let anchorList: [Any?] = nilOrValue(list[2]) {
      anchor = ScreenCoordinate.fromList(anchorList)
    }
    let zoom: Double? = nilOrValue(list[3])
    let bearing: Double? = nilOrValue(list[4])
    let pitch: Double? = nilOrValue(list[5])

    return CameraOptions(
      center: center,
      padding: padding,
      anchor: anchor,
      zoom: zoom,
      bearing: bearing,
      pitch: pitch
    )
  }
  func toList() -> [Any?] {
    return [
      center,
      padding?.toList(),
      anchor?.toList(),
      zoom,
      bearing,
      pitch,
    ]
  }
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
struct CoordinateBounds {
  /// Coordinate at the southwest corner.
  /// Note: setting this field with invalid values (infinite, NaN) will crash the application.
  var southwest: [String?: Any?]
  /// Coordinate at the northeast corner.
  /// Note: setting this field with invalid values (infinite, NaN) will crash the application.
  var northeast: [String?: Any?]
  /// If set to `true`, an infinite (unconstrained) bounds covering the world coordinates would be used.
  /// Coordinates provided in `southwest` and `northeast` fields would be omitted and have no effect.
  var infiniteBounds: Bool

  static func fromList(_ list: [Any?]) -> CoordinateBounds? {
    let southwest = list[0] as! [String?: Any?]
    let northeast = list[1] as! [String?: Any?]
    let infiniteBounds = list[2] as! Bool

    return CoordinateBounds(
      southwest: southwest,
      northeast: northeast,
      infiniteBounds: infiniteBounds
    )
  }
  func toList() -> [Any?] {
    return [
      southwest,
      northeast,
      infiniteBounds,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct CameraState {
  /// Coordinate at the center of the camera.
  var center: [String?: Any?]
  /// Padding around the interior of the view that affects the frame of
  /// reference for `center`.
  var padding: MbxEdgeInsets
  /// Zero-based zoom level. Constrained to the minimum and maximum zoom
  /// levels.
  var zoom: Double
  /// Bearing, measured in degrees from true north. Wrapped to [0, 360).
  var bearing: Double
  /// Pitch toward the horizon measured in degrees.
  var pitch: Double

  static func fromList(_ list: [Any?]) -> CameraState? {
    let center = list[0] as! [String?: Any?]
    let padding = MbxEdgeInsets.fromList(list[1] as! [Any?])!
    let zoom = list[2] as! Double
    let bearing = list[3] as! Double
    let pitch = list[4] as! Double

    return CameraState(
      center: center,
      padding: padding,
      zoom: zoom,
      bearing: bearing,
      pitch: pitch
    )
  }
  func toList() -> [Any?] {
    return [
      center,
      padding.toList(),
      zoom,
      bearing,
      pitch,
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

private class _SnapshotterMessagerCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 128:
      return CameraOptions.fromList(self.readValue() as! [Any?])
    case 129:
      return CameraState.fromList(self.readValue() as! [Any?])
    case 130:
      return CoordinateBounds.fromList(self.readValue() as! [Any?])
    case 131:
      return MbxEdgeInsets.fromList(self.readValue() as! [Any?])
    case 132:
      return MbxImage.fromList(self.readValue() as! [Any?])
    case 133:
      return ScreenCoordinate.fromList(self.readValue() as! [Any?])
    case 134:
      return Size.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class _SnapshotterMessagerCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? CameraOptions {
      super.writeByte(128)
      super.writeValue(value.toList())
    } else if let value = value as? CameraState {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? CoordinateBounds {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? MbxEdgeInsets {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? MbxImage {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else if let value = value as? ScreenCoordinate {
      super.writeByte(133)
      super.writeValue(value.toList())
    } else if let value = value as? Size {
      super.writeByte(134)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class _SnapshotterMessagerCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return _SnapshotterMessagerCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return _SnapshotterMessagerCodecWriter(data: data)
  }
}

class _SnapshotterMessagerCodec: FlutterStandardMessageCodec {
  static let shared = _SnapshotterMessagerCodec(readerWriter: _SnapshotterMessagerCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol _SnapshotterMessager {
  func cancel(id: String) throws
  func destroy(id: String) throws
  func setCamera(id: String, cameraOptions: CameraOptions) throws
  func setStyleUri(id: String, styleUri: String) throws
  func setStyleJson(id: String, styleJson: String) throws
  func setSize(id: String, size: Size) throws
  func cameraForCoordinates(id: String, coordinates: [[String?: Any?]?], padding: MbxEdgeInsets, bearing: Double?, pitch: Double?) throws -> CameraOptions
  func coordinateBoundsForCamera(id: String, camera: CameraOptions) throws -> CoordinateBounds
  func getCameraState(id: String) throws -> CameraState
  func getSize(id: String) throws -> Size
  func getStyleJson(id: String) throws -> String
  func getStyleUri(id: String) throws -> String
  func start(id: String, completion: @escaping (Result<MbxImage?, Error>) -> Void)
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class _SnapshotterMessagerSetup {
  /// The codec used by _SnapshotterMessager.
  static var codec: FlutterStandardMessageCodec { _SnapshotterMessagerCodec.shared }
  /// Sets up an instance of `_SnapshotterMessager` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: _SnapshotterMessager?) {
    let cancelChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.cancel", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      cancelChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          try api.cancel(id: idArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      cancelChannel.setMessageHandler(nil)
    }
    let destroyChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.destroy", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      destroyChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          try api.destroy(id: idArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      destroyChannel.setMessageHandler(nil)
    }
    let setCameraChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.setCamera", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setCameraChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let cameraOptionsArg = args[1] as! CameraOptions
        do {
          try api.setCamera(id: idArg, cameraOptions: cameraOptionsArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setCameraChannel.setMessageHandler(nil)
    }
    let setStyleUriChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.setStyleUri", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setStyleUriChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let styleUriArg = args[1] as! String
        do {
          try api.setStyleUri(id: idArg, styleUri: styleUriArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setStyleUriChannel.setMessageHandler(nil)
    }
    let setStyleJsonChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.setStyleJson", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setStyleJsonChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let styleJsonArg = args[1] as! String
        do {
          try api.setStyleJson(id: idArg, styleJson: styleJsonArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setStyleJsonChannel.setMessageHandler(nil)
    }
    let setSizeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.setSize", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      setSizeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let sizeArg = args[1] as! Size
        do {
          try api.setSize(id: idArg, size: sizeArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      setSizeChannel.setMessageHandler(nil)
    }
    let cameraForCoordinatesChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.cameraForCoordinates", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      cameraForCoordinatesChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let coordinatesArg = args[1] as! [[String?: Any?]?]
        let paddingArg = args[2] as! MbxEdgeInsets
        let bearingArg: Double? = nilOrValue(args[3])
        let pitchArg: Double? = nilOrValue(args[4])
        do {
          let result = try api.cameraForCoordinates(id: idArg, coordinates: coordinatesArg, padding: paddingArg, bearing: bearingArg, pitch: pitchArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      cameraForCoordinatesChannel.setMessageHandler(nil)
    }
    let coordinateBoundsForCameraChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.coordinateBoundsForCamera", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      coordinateBoundsForCameraChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        let cameraArg = args[1] as! CameraOptions
        do {
          let result = try api.coordinateBoundsForCamera(id: idArg, camera: cameraArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      coordinateBoundsForCameraChannel.setMessageHandler(nil)
    }
    let getCameraStateChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.getCameraState", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getCameraStateChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          let result = try api.getCameraState(id: idArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getCameraStateChannel.setMessageHandler(nil)
    }
    let getSizeChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.getSize", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getSizeChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          let result = try api.getSize(id: idArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getSizeChannel.setMessageHandler(nil)
    }
    let getStyleJsonChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.getStyleJson", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getStyleJsonChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          let result = try api.getStyleJson(id: idArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getStyleJsonChannel.setMessageHandler(nil)
    }
    let getStyleUriChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.getStyleUri", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getStyleUriChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        do {
          let result = try api.getStyleUri(id: idArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getStyleUriChannel.setMessageHandler(nil)
    }
    let startChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.mapbox_maps_flutter._SnapshotterMessager.start", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let idArg = args[0] as! String
        api.start(id: idArg) { result in
          switch result {
          case .success(let res):
            reply(wrapResult(res))
          case .failure(let error):
            reply(wrapError(error))
          }
        }
      }
    } else {
      startChannel.setMessageHandler(nil)
    }
  }
}
/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol OnSnapshotStyleListenerProtocol {
  func onDidFinishLoadingStyle(completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onDidFullyLoadStyle(completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onDidFailLoadingStyle(message messageArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)
  func onStyleImageMissing(imageId imageIdArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void)
}
class OnSnapshotStyleListener: OnSnapshotStyleListenerProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  init(binaryMessenger: FlutterBinaryMessenger) {
    self.binaryMessenger = binaryMessenger
  }
  func onDidFinishLoadingStyle(completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.mapbox_maps_flutter.OnSnapshotStyleListener.onDidFinishLoadingStyle"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onDidFullyLoadStyle(completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.mapbox_maps_flutter.OnSnapshotStyleListener.onDidFullyLoadStyle"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage(nil) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onDidFailLoadingStyle(message messageArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.mapbox_maps_flutter.OnSnapshotStyleListener.onDidFailLoadingStyle"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage([messageArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
  func onStyleImageMissing(imageId imageIdArg: String, completion: @escaping (Result<Void, FlutterError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.mapbox_maps_flutter.OnSnapshotStyleListener.onStyleImageMissing"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger)
    channel.sendMessage([imageIdArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(FlutterError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
