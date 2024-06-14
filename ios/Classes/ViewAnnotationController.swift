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
    
    func createMarkerView() -> UIView {
        
        let checkbox = createCheckbox()
        checkbox.translatesAutoresizingMaskIntoConstraints = false
        
        let textInfo = createMarkerText();
        let text = textInfo.0;
        text.translatesAutoresizingMaskIntoConstraints = false
        
        let textWidth = textInfo.1;
        let textHeight = textInfo.2;
        
        let quickLink = createMarkerQuickLink();
        quickLink.translatesAutoresizingMaskIntoConstraints = false
        
        let root = UIView()
        let rootHeight = textHeight + 12
        let rootWidth = textWidth + 24 * 2 + 2 * 2
        
        
        root.addSubview(text)
        root.addSubview(checkbox)
        root.addSubview(quickLink)
        
        
        root.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            root.widthAnchor.constraint(lessThanOrEqualToConstant: rootWidth),
            root.heightAnchor.constraint(lessThanOrEqualToConstant: rootHeight),
            
            text.topAnchor.constraint(equalTo: root.topAnchor, constant: 12),
            text.leftAnchor.constraint(equalTo: root.leftAnchor, constant: 26),
            
            quickLink.leftAnchor.constraint(equalTo: text.rightAnchor, constant: 2),
            quickLink.topAnchor.constraint(equalTo: text.topAnchor, constant: 0),
            
            
            checkbox.rightAnchor.constraint(equalTo: text.leftAnchor,constant: 12),
            checkbox.topAnchor.constraint(equalTo: root.topAnchor, constant: 0)
        ])
        
        return root
    }
    
    func createCheckbox() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 6
        view.layer.borderColor = UIColor(red: 204 / 255.0, green: 202 / 255.0, blue: 204 / 255.0, alpha: 1).cgColor // rgba(204, 202, 204, 1)
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 24),
            view.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        return view
    }
    
    func createMarkerQuickLink() -> UIView {
        let image = UIImage()
        
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 6
        imageView.layer.borderColor = UIColor(red: 150 / 255.0, green: 77 / 255.0, blue: 255 / 255.0, alpha: 1).cgColor // #964DFF
        imageView.layer.borderWidth = 1
        imageView.backgroundColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24)
        ])
        return imageView
    }
    
    func createMarkerText() -> (UIView, CGFloat,CGFloat) {
        let maxWidth = 120.0
        let paddingHorizontal = 6.0
        let paddingVertical = 4.0;
        
        let textContainer = UIView()
        textContainer.backgroundColor = UIColor(red: 150 / 255.0, green: 77 / 255.0, blue: 255 / 255.0, alpha: 1) // #964DFF
        textContainer.layer.borderWidth = 1
        textContainer.layer.borderColor = UIColor.white.cgColor
        textContainer.layer.cornerRadius = 6
  
        let textLable = UILabel()
        textContainer.addSubview(textLable)
        
        // 设置最大宽度
        textContainer.translatesAutoresizingMaskIntoConstraints = false
        textContainer.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth).isActive = true
        
        textLable.text = "这个是自定义的view用来测试功能很长很长的句子后面省略号这个是自定义的view用来测试功能很长很长的句子后面省略号"
        textLable.textColor = .white
        textLable.numberOfLines = 2
        textLable.font = UIFont.systemFont(ofSize: 10)
        textLable.preferredMaxLayoutWidth = maxWidth - paddingHorizontal
        textLable.lineBreakMode = .byTruncatingTail
        
        // 设置自动约束
        textLable.translatesAutoresizingMaskIntoConstraints = false
        
        // 设置对齐上下左右
        NSLayoutConstraint.activate([
            textLable.leadingAnchor.constraint(equalTo: textContainer.leadingAnchor, constant: paddingHorizontal),
            textLable.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: paddingVertical),
        ])
        
        let size = textLable.sizeThatFits(CGSize(width: maxWidth - paddingHorizontal, height: CGFloat.greatestFiniteMagnitude))
        let height = max(size.height + paddingVertical * 2, 24)
        let width = size.width + paddingHorizontal * 2
        textContainer.heightAnchor.constraint(equalToConstant: height).isActive = true
        textContainer.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        return (textContainer, width, height)
    }
    
    func addViewAnnotation(data: FlutterStandardTypedData, options: ViewAnnotationOptions, completion: @escaping (Result<Int64, Error>) -> Void) {
//        let uiImage = UIImage(data: data.data, scale: UIScreen.main.scale)
//        if uiImage == nil {
//            completion(.failure(FlutterError(code: ViewAnnotationController.errorCode, message: "image data is nil", details: nil)))
//            return
//        }
//        let viewAnnotation = options.toViewAnnotion(uiImage: uiImage!)
//        if viewAnnotation == nil {
//            completion(.failure(FlutterError(code: ViewAnnotationController.errorCode, message: "options.annotatedFeature must to set", details: nil)))
//            return
//        }
//        let id = UUID().uuidString.hashValue
//        viewAnnotation!.view.tag = id
//        viewAnnotation!.onAnchorCoordinateChanged = { [weak self] coordinate in
//            self?.onViewAnnotationUpdatedListener?.onViewAnnotationAnchorCoordinateUpdated(viewId: Int64(id), anchorCoordinate: coordinate.toDict(), completion: {error in})
//        }
//        viewAnnotation!.onAnchorChanged = { [weak self] config in
//            self?.onViewAnnotationUpdatedListener?.onViewAnnotationAnchorUpdated(viewId: Int64(id), anchor: config.toFLTViewAnnotationAnchorConfig(), completion: {error in})
//        }
//        viewAnnotation!.onVisibilityChanged = { [weak self] visibility in
//            self?.onViewAnnotationUpdatedListener?.onViewAnnotationVisibilityUpdated(viewId: Int64(id), visible: visibility, completion: {error in})
//        }
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewAnnotationTapped))
//        viewAnnotation!.view.isUserInteractionEnabled = true
//        viewAnnotation!.view.addGestureRecognizer(tapGesture)
//        
//        mapView.viewAnnotations.add(viewAnnotation!)
//        annotationMap[id] = viewAnnotation!
//        completion(.success(Int64(id)))
        
        let feature = options.annotatedFeature?.toAnnotatedFeature()
        if feature == nil {
            return
        }
        let viewAnnotation = ViewAnnotation(annotatedFeature: feature!, view: createMarkerView())
        viewAnnotation.allowOverlap = true
        viewAnnotation.visible = true
        viewAnnotation.variableAnchors = [MapboxMaps.ViewAnnotationAnchorConfig(anchor: MapboxMaps.ViewAnnotationAnchor.bottom, offsetX: 0, offsetY: 12)]
        let id = UUID().uuidString.hashValue
        viewAnnotation.view.tag = id
        mapView.viewAnnotations.add(viewAnnotation)
        annotationMap[id] = viewAnnotation
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
