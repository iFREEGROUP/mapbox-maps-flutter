import Foundation
import MapboxMaps

class ViewAnnotationController: NSObject, FLTViewAnnotationManager {
    
    private var mapView: MapView
    private var onViewAnnotationClickListener: FLTOnViewAnnotationTapListener?
    private var onViewAnnotationUpdatedListener: FLTOnViewAnnotationUpdatedListener?
    private static let errorCode = "0"
    private var annotationMap: [Int: ViewAnnotation] = [:]
    
    
    init(withMapView mapView: MapView) {
        self.mapView = mapView
    }
    
    func setup(withMessager messager: FlutterBinaryMessenger) {
        SetUpFLTViewAnnotationManager(messager, self)
        onViewAnnotationClickListener = FLTOnViewAnnotationTapListener(binaryMessenger: messager)
        onViewAnnotationUpdatedListener = FLTOnViewAnnotationUpdatedListener(binaryMessenger: messager)
    }
    
    func addViewAnnotationData(_ data: FlutterStandardTypedData, options: FLTViewAnnotationOptions, completion: @escaping (NSNumber?, FlutterError?) -> Void) {
        let uiImage = UIImage(data: data.data, scale: UIScreen.main.scale)
        if uiImage == nil {
            completion(nil, FlutterError(code: ViewAnnotationController.errorCode, message: "image data is nil", details: nil))
            return
        }
        let viewAnnotation = options.toViewAnnotion(uiImage: uiImage!)
        if viewAnnotation == nil {
            completion(nil, FlutterError(code: ViewAnnotationController.errorCode, message: "options.annotatedFeature must to set", details: nil))
            return
        }
        let id = UUID().uuidString.hashValue
        viewAnnotation!.onAnchorCoordinateChanged = { [weak self] coordinate in
            self?.onViewAnnotationUpdatedListener?.onViewAnnotationAnchorCoordinateUpdatedViewId(id, anchorCoordinate: coordinate.toDict(), completion: {error in})
        }
        viewAnnotation!.onAnchorChanged = { [weak self] config in
            self?.onViewAnnotationUpdatedListener?.onViewAnnotationAnchorUpdatedViewId(id, anchor: config.toFLTViewAnnotationAnchorConfig(), completion: {error in})
        }
        viewAnnotation!.onVisibilityChanged = { [weak self] visibility in
            self?.onViewAnnotationUpdatedListener?.onViewAnnotationVisibilityUpdatedViewId(id, visible: visibility, completion: {error in})
        }
        mapView.viewAnnotations.add(viewAnnotation!)
        annotationMap[id] = viewAnnotation!
        completion(NSNumber(integerLiteral: id),nil)
    }
    
    func removeAllViewAnnotations(completion: @escaping (FlutterError?) -> Void) {
        mapView.viewAnnotations.removeAll()
        annotationMap.removeAll()
        completion(nil)
    }
    
    func removeViewAnnotationViewId(_ viewId: Int, completion: @escaping (FlutterError?) -> Void) {
        let viewAnnotation = annotationMap[viewId]
        if viewAnnotation == nil {
            completion(FlutterError(code: ViewAnnotationController.errorCode, message: "no viewAnnotation found", details: nil))
            return
        }
        viewAnnotation!.remove()
        annotationMap.removeValue(forKey: viewId)
        completion(nil)
    }
    
    func updateViewAnnotationViewId(_ viewId: Int, options: FLTViewAnnotationOptions, data: FlutterStandardTypedData?, completion: @escaping (NSNumber?, FlutterError?) -> Void) {
        let viewAnnotation = annotationMap[viewId]
        if viewAnnotation == nil {
            completion(NSNumber(booleanLiteral: false),nil)
            return
        }
        if let data = data {
            let uiImage = UIImage(data: data.data)
            (viewAnnotation!.view as! UIImageView).image = uiImage
        }
        if options.width != nil && options.height != nil {
            viewAnnotation!.view.frame = CGRect(x: 0, y: 0, width: options.width!.intValue, height: options.height!.intValue)
            viewAnnotation!.setNeedsUpdateSize()
        }
        if let allowOverlap = options.allowOverlap {
            viewAnnotation!.allowOverlap = allowOverlap == 1
        }
        if let allowOverlapWithPuck = options.allowOverlapWithPuck {
            viewAnnotation!.allowOverlapWithPuck = allowOverlapWithPuck == 1
        }
        if let ignoreCameraPadding = options.ignoreCameraPadding {
            viewAnnotation!.ignoreCameraPadding = ignoreCameraPadding == 1
        }
        if let selected = options.selected {
            viewAnnotation!.selected = selected == 1
        }
        if let visible = options.visible {
            viewAnnotation!.visible = visible == 1
        }
        if let annotatedFeature = options.annotatedFeature?.toAnnotatedFeature() {
            viewAnnotation!.annotatedFeature = annotatedFeature
        }
        if let variableAnchors = options.variableAnchors?.compactMap({ item in
            item.toViewAnnotationAnchorConfig()
        }) {
            viewAnnotation!.variableAnchors = variableAnchors
        }
        completion(NSNumber(booleanLiteral: true),nil)
    }
    
    func getViewAnnotationOptionsAnnotatedLayerFeature(_ annotatedLayerFeature: FLTAnnotatedLayerFeature, completion: @escaping (FLTViewAnnotationOptions?, FlutterError?) -> Void) {
        let viewAnnotation = annotationMap.values.filter { item in
            if let layerFeature = item.annotatedFeature.layerFeature {
                return layerFeature.layerId == annotatedLayerFeature.layerId && layerFeature.featureId == annotatedLayerFeature.featureId
            }
            return false
        }
        if viewAnnotation.isEmpty {
            completion(nil,nil)
            return
        }
        completion(viewAnnotation[0].toFLTViewAnnotationOptions(),nil)
    }
    
    func getViewAnnotationOptions(byViewIdViewId viewId: Int, completion: @escaping (FLTViewAnnotationOptions?, FlutterError?) -> Void) {
        let viewAnnotation = annotationMap[viewId]
        if viewAnnotation == nil {
            completion(nil,nil)
            return
        }
        completion(viewAnnotation!.toFLTViewAnnotationOptions(),nil)
    }
    
    func setViewAnnotationUpdateModeMode(_ mode: FLTViewAnnotationUpdateMode, completion: @escaping (FlutterError?) -> Void) {
        completion(nil)
    }
    
    func getViewAnnotationUpdateMode(completion: @escaping (FLTViewAnnotationUpdateModeBox?, FlutterError?) -> Void) {
        completion(nil,nil)
    }
}
