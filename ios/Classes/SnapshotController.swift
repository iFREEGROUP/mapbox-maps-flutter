import Foundation
import MapboxMaps
import Flutter

public enum SnapshotControllerError: Error {
    case noSnapshotterFound
}

public protocol SnapshotControllerDelegate : AnyObject {
    func getSnapshotter(id: String) throws -> Snapshotter
    
    func remove(id: String)
}

class SnapshotController: NSObject,_SnapShotManager,SnapshotControllerDelegate {
 
    private var mapView: MapView
    private var onSnapshotStyleListener: OnSnapshotStyleListener?
    private var snapshotterMap: [String: Snapshotter] = [:]
    private var cancelables: [String: Set<AnyCancelable>] = [:]
    private var snapshotter: SnapshotterManager?
    
    init(mapView: MapView) {
        self.mapView = mapView
        super.init()
        snapshotter = SnapshotterManager(withDelegate: self)
    }
    
    func create(options: MapSnapshotOptions, overlayOptions: SnapshotOverlayOptions) throws -> String {
        let snapshotOptions = MapboxMaps.MapSnapshotOptions.init(size: CGSize(width: options.size.width, height: options.size.height), pixelRatio: options.pixelRatio,showsLogo: overlayOptions.showLogo,showsAttribution: overlayOptions.showAttributes)
        let snapshotter = Snapshotter(options: snapshotOptions)
        let id = UUID().uuidString.replacingOccurrences(of: "-", with: "")
        snapshotterMap[id] = snapshotter
        
        cancelables[id] = Set()
        
        snapshotter.onStyleLoaded.observe { [weak self] style in
            self?.onSnapshotStyleListener?.onDidFinishLoadingStyle(completion: { flutterError in
            })
        }.store(in: &cancelables[id]!)
    
        snapshotter.onStyleDataLoaded.observe { [weak self] styleDataLoad in
            self?.onSnapshotStyleListener?.onDidFullyLoadStyle(completion: { flutterError in
                
            })
        }.store(in: &cancelables[id]!)
        
        snapshotter.onMapLoadingError.observe { [weak self] mapLoadingError in
            self?.onSnapshotStyleListener?.onDidFailLoadingStyle(message: mapLoadingError.message, completion: { flutterError in
            })
        }.store(in: &cancelables[id]!)
        
        snapshotter.onStyleImageMissing.observe { [weak self] styleImageMissing in
            self?.onSnapshotStyleListener?.onStyleImageMissing(imageId: styleImageMissing.imageId, completion: { flutterError in
            })
        }.store(in: &cancelables[id]!)
        
        return id
    }
    
    func snapshot(completion: @escaping (Result<MbxImage?, Error>) -> Void) {
        let uiImage = try? mapView.snapshot()
        guard let image = uiImage else {
            completion(Result.success(nil))
            return
        }
        completion(Result.success(image.toFLTMbxImage()))
    }
    
    func setup(messager: FlutterBinaryMessenger) {
        _SnapShotManagerSetup.setUp(binaryMessenger: messager, api: self)
        onSnapshotStyleListener = OnSnapshotStyleListener.init(binaryMessenger: messager)
        _SnapshotterMessagerSetup.setUp(binaryMessenger: messager, api: snapshotter)
    }
    
    
    func getSnapshotter(id: String) throws -> MapboxMaps.Snapshotter {
        if snapshotterMap[id] == nil {
            throw SnapshotControllerError.noSnapshotterFound
        }
        return snapshotterMap[id]!
    }
    
    func remove(id: String) {
        snapshotterMap.removeValue(forKey: id)
        cancelables[id]?.forEach({ anyCancelable in
            anyCancelable.cancel()
        })
        cancelables[id]?.removeAll()
    }

    func tearDown(messenger: FlutterBinaryMessenger) {
        _SnapShotManagerSetup.setUp(binaryMessenger: messenger, api: nil)
        _SnapshotterMessagerSetup.setUp(binaryMessenger: messenger, api: nil)
        onSnapshotStyleListener = nil
        cancelables.keys.forEach { key in
            remove(id: key)
        }
        snapshotterMap.removeAll()
        cancelables.removeAll()
        snapshotter = nil
    }
}
