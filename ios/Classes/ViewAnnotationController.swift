import Foundation
import MapboxMaps
import Flutter

class ViewAnnotationController: NSObject, ViewAnnotationManager {

    private var mapView: MapView
    private var onViewAnnotationClickListener: OnViewAnnotationTapListener?
    private var onViewAnnotationUpdatedListener: OnViewAnnotationUpdatedListener?
    private static let errorCode = "0"
    private var annotationMap: [Int: ViewAnnotation] = [:]
    
    
    init(withMapView mapView: MapView) {
        self.mapView = mapView
    }
    
    func setup(withMessager messager: FlutterBinaryMessenger) {
        ViewAnnotationManagerSetup.setUp(binaryMessenger: messager, api: self)
        onViewAnnotationClickListener = OnViewAnnotationTapListener(binaryMessenger: messager)
        onViewAnnotationUpdatedListener = OnViewAnnotationUpdatedListener(binaryMessenger: messager)
    }
    
    func addViewAnnotation(data: FlutterStandardTypedData, options: ViewAnnotationOptions, completion: @escaping (Result<Int64, Error>) -> Void) {
        let uiImage = UIImage(data: data.data, scale: UIScreen.main.scale)
        if uiImage == nil {
            completion(.failure(FlutterError(code: ViewAnnotationController.errorCode, message: "image data is nil", details: nil)))
            return
        }
        let viewAnnotation = options.toViewAnnotion(uiImage: uiImage!)
        if viewAnnotation == nil {
            completion(.failure(FlutterError(code: ViewAnnotationController.errorCode, message: "options.annotatedFeature must to set", details: nil)))
            return
        }
        let id = UUID().uuidString.hashValue
        viewAnnotation!.view.tag = id
        viewAnnotation!.onAnchorCoordinateChanged = { [weak self] coordinate in
            self?.onViewAnnotationUpdatedListener?.onViewAnnotationAnchorCoordinateUpdated(viewId: Int64(id), anchorCoordinate: coordinate.toDict(), completion: {error in})
        }
        viewAnnotation!.onAnchorChanged = { [weak self] config in
            self?.onViewAnnotationUpdatedListener?.onViewAnnotationAnchorUpdated(viewId: Int64(id), anchor: config.toFLTViewAnnotationAnchorConfig(), completion: {error in})
        }
        viewAnnotation!.onVisibilityChanged = { [weak self] visibility in
            self?.onViewAnnotationUpdatedListener?.onViewAnnotationVisibilityUpdated(viewId: Int64(id), visible: visibility, completion: {error in})
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewAnnotationTapped))
        viewAnnotation!.view.isUserInteractionEnabled = true
        viewAnnotation!.view.addGestureRecognizer(tapGesture)
        
        mapView.viewAnnotations.add(viewAnnotation!)
        annotationMap[id] = viewAnnotation!
        completion(.success(Int64(id)))
    }
    
    func removeViewAnnotation(viewId: Int64, completion: @escaping (Result<Void, Error>) -> Void) {
        let viewAnnotation = annotationMap[Int(viewId)]
        if viewAnnotation == nil {
            completion(.failure(FlutterError(code: ViewAnnotationController.errorCode, message: "no viewAnnotation found", details: nil)))
            return
        }
        viewAnnotation!.remove()
        annotationMap.removeValue(forKey: Int(viewId))
        completion(.success(()))
    }
    
    @objc func viewAnnotationTapped(_ sender: UITapGestureRecognizer) {
        onViewAnnotationClickListener?.onViewAnnotationClick(viewId: Int64(sender.view!.tag), completion: {error in})
    }
    
    func removeAllViewAnnotations(completion: @escaping (Result<Void, Error>) -> Void) {
        mapView.viewAnnotations.removeAll()
        annotationMap.removeAll()
        completion(.success(()))
    }
    
    func updateViewAnnotation(viewId: Int64, options: ViewAnnotationOptions, data: FlutterStandardTypedData?, completion: @escaping (Result<Bool, Error>) -> Void) {
        let viewAnnotation = annotationMap[Int(viewId)]
        if viewAnnotation == nil {
            completion(.success(false))
            return
        }
        if let data = data {
            let uiImage = UIImage(data: data.data)
            (viewAnnotation!.view as! UIImageView).image = uiImage
        }
        if options.width != nil && options.height != nil {
            viewAnnotation!.view.frame = CGRect(x: 0, y: 0, width: options.width!, height: options.height!)
            viewAnnotation!.setNeedsUpdateSize()
        }
        if let allowOverlap = options.allowOverlap {
            viewAnnotation!.allowOverlap = allowOverlap
        }
        if let allowOverlapWithPuck = options.allowOverlapWithPuck {
            viewAnnotation!.allowOverlapWithPuck = allowOverlapWithPuck
        }
        if let ignoreCameraPadding = options.ignoreCameraPadding {
            viewAnnotation!.ignoreCameraPadding = ignoreCameraPadding
        }
        if let selected = options.selected {
            viewAnnotation!.selected = selected
        }
        if let visible = options.visible {
            viewAnnotation!.visible = visible
        }
        if let annotatedFeature = options.annotatedFeature?.toAnnotatedFeature() {
            viewAnnotation!.annotatedFeature = annotatedFeature
        }
        if let variableAnchors = options.variableAnchors?.compactMap({ item in
            item?.toViewAnnotationAnchorConfig()
        }) {
            viewAnnotation!.variableAnchors = variableAnchors
        }
        completion(.success(true))
    }

    func getViewAnnotationOptionsByViewId(viewId: Int64, completion: @escaping (Result<ViewAnnotationOptions?, Error>) -> Void) {
        let viewAnnotation = annotationMap[Int(viewId)]
        if viewAnnotation == nil {
            completion(.success(nil))
            return
        }
        completion(.success(viewAnnotation!.toFLTViewAnnotationOptions()))
    }
    
    func setViewAnnotationUpdateMode(mode: ViewAnnotationUpdateMode, completion: @escaping (Result<Void, Error>) -> Void) {
        completion(.success(()))
    }
    
    func getViewAnnotationOptions(annotatedLayerFeature: AnnotatedLayerFeature, completion: @escaping (Result<ViewAnnotationOptions?, Error>) -> Void) {
        let viewAnnotation = annotationMap.values.filter { item in
            if let layerFeature = item.annotatedFeature.layerFeature {
                return layerFeature.layerId == annotatedLayerFeature.layerId && layerFeature.featureId == annotatedLayerFeature.featureId
            }
            return false
        }
        if viewAnnotation.isEmpty {
            completion(.success(nil))
            return
        }
        completion(.success(viewAnnotation[0].toFLTViewAnnotationOptions()))
    }
    
    func getViewAnnotationUpdateMode(completion: @escaping (Result<ViewAnnotationUpdateMode, Error>) -> Void) {
        completion(.failure(FlutterError(code: ViewAnnotationController.errorCode, message: "UnSupport", details: nil)))
    }
    
}
