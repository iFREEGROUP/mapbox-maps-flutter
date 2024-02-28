import Foundation
import MapboxMaps
import Flutter

class SnapshotterManager : NSObject, _SnapshotterMessager {
    
    private var delegate: SnapshotControllerDelegate
    private static let errorCode = "0"
    
    init(withDelegate delegate: SnapshotControllerDelegate) {
        self.delegate = delegate
    }
    
    func cancel(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try delegate.getSnapshotter(id: id).cancel()
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode, message: error.localizedDescription, details: nil)))
        }
    }
    
    func destroy(id: String, completion: @escaping (Result<Void, Error>) -> Void) {
        delegate.remove(id: id)
        completion(.success(()))
    }
    
    func setCamera(id: String, cameraOptions: CameraOptions, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try delegate.getSnapshotter(id: id).setCamera(to: cameraOptions.toCameraOptions())
            completion(.success(()))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func setStyleUri(id: String, styleUri: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try delegate.getSnapshotter(id: id).styleURI = StyleURI.init(rawValue: styleUri)
            completion(.success(()))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func setStyleJson(id: String, styleJson: String, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try delegate.getSnapshotter(id: id).styleJSON = styleJson
            completion(.success(()))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func setSize(id: String, size: Size, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try delegate.getSnapshotter(id: id).snapshotSize = CGSize(width: size.width, height: size.height)
            completion(.success(()))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func cameraForCoordinates(id: String, coordinates: [[String? : Any?]?], padding: MbxEdgeInsets, bearing: Double?, pitch: Double?, completion: @escaping (Result<CameraOptions, Error>) -> Void) {
        do {
            let cameraOptions = try delegate.getSnapshotter(id: id).camera(for: coordinates.compactMap(convertDictionaryToCLLocationCoordinate2D(dict:)), padding: padding.toUIEdgeInsets(), bearing: bearing, pitch: pitch)
            completion(.success(cameraOptions.toFLTCameraOptions()))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func coordinateBoundsForCamera(id: String, camera: CameraOptions, completion: @escaping (Result<CoordinateBounds, Error>) -> Void) {
        do {
            let coordinateBounds = try delegate.getSnapshotter(id: id).coordinateBounds(for: camera.toCameraOptions())
            completion(.success(coordinateBounds.toFLTCoordinateBounds()))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func getCameraState(id: String, completion: @escaping (Result<CameraState, Error>) -> Void) {
        do {
            let camera = try delegate.getSnapshotter(id: id).cameraState
            completion(.success(camera.toFLTCameraState()))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func getSize(id: String, completion: @escaping (Result<Size, Error>) -> Void) {
        do {
            let size = try delegate.getSnapshotter(id: id).snapshotSize
            completion(.success(size.toFLTSize()))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func getStyleJson(id: String, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            let json = try delegate.getSnapshotter(id: id).styleJSON
            completion(.success(json))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func getStyleUri(id: String, completion: @escaping (Result<String, Error>) -> Void) {
        do {
            let uri = try delegate.getSnapshotter(id: id).styleURI
            completion(.success(uri?.rawValue ?? ""))
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
    func start(id: String, completion: @escaping (Result<MbxImage?, Error>) -> Void) {
        do {
            try delegate.getSnapshotter(id: id).start(overlayHandler: nil) { snapshotResult in
                let image = try? snapshotResult.get()
                if  image != nil {
                    completion(.success(image!.toFLTMbxImage()))
                } else {
                    completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: "snapshot fail",details: nil)))
                }
            }
        } catch {
            completion(.failure(FlutterError(code: SnapshotterManager.errorCode,message: error.localizedDescription,details: nil)))
        }
    }
    
}
