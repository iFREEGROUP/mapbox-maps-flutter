import 'package:pigeon/pigeon.dart';

enum AnnotatedFeatureType { GEOMETRY, ANNOTATED_LAYER_FEATURE }

class AnnotatedFeature {
  // Map<String?, Object?>? geometry or AnnotatedLayerFeature
  Object value;
  AnnotatedFeatureType type;

  AnnotatedFeature(this.value, this.type);
}

enum ViewAnnotationAnchor {
  // The center of the view annotation is placed closest to the geometry.
  CENTER,
  // The top of the view annotation is placed closest to the geometry.
  TOP,
  // The left side of the view annotation is placed closest to the geometry.
  LEFT,
  // The bottom of the view annotation is placed closest to the geometry.
  BOTTOM,
  // The right side of the view annotation is placed closest to the geometry.
  RIGHT,
  // The top-left corner of the view annotation is placed closest to the geometry.
  TOP_LEFT,
  // The bottom-right corner of the view annotation is placed closest to the geometry.
  BOTTOM_RIGHT,
  // The top-right corner of the view annotation is placed closest to the geometry.
  TOP_RIGHT,
  // The bottom-left corner of the view annotation is placed closest to the geometry.
  BOTTOM_LEFT;
}

class ViewAnnotationAnchorConfig {
  ViewAnnotationAnchor anchor;
  double offsetX;
  double offsetY;

  ViewAnnotationAnchorConfig(this.anchor, this.offsetX, this.offsetY);
}

class ViewAnnotationOptions {
  AnnotatedFeature? annotatedFeature;
  double? width;
  double? height;
  bool? allowOverlap;
  bool? allowOverlapWithPuck;
  bool? visible;
  List<ViewAnnotationAnchorConfig?>? variableAnchors;
  bool? selected;
  bool? ignoreCameraPadding;

  ViewAnnotationOptions({
    this.annotatedFeature,
    this.width,
    this.height,
    this.allowOverlap,
    this.allowOverlapWithPuck,
    this.variableAnchors,
    this.visible,
    this.selected,
    this.ignoreCameraPadding,
  });
}

class AnnotatedLayerFeature {
  String layerId;
  String? featureId;

  AnnotatedLayerFeature(this.layerId, this.featureId);
}

enum ViewAnnotationUpdateMode { MAP_FIXED_DELAY, MAP_SYNCHRONIZED }

class ScreenCoordinate {
  double x;
  double y;

  ScreenCoordinate(this.x, this.y);
}

@HostApi()
abstract class ViewAnnotationManager {
  @async
  int addViewAnnotation(Uint8List data, ViewAnnotationOptions options);

  @async
  void removeAllViewAnnotations();

  @async
  void removeViewAnnotation(int viewId);

  @async
  bool updateViewAnnotation(int viewId, ViewAnnotationOptions options, {Uint8List? data});

  @async
  ViewAnnotationOptions? getViewAnnotationOptions(AnnotatedLayerFeature annotatedLayerFeature);

  @async
  ViewAnnotationOptions? getViewAnnotationOptionsByViewId(int viewId);

  @async
  void setViewAnnotationUpdateMode(ViewAnnotationUpdateMode mode);

  @async
  ViewAnnotationUpdateMode getViewAnnotationUpdateMode();
}

@FlutterApi()
abstract class OnViewAnnotationUpdatedListener {
  void onViewAnnotationPositionUpdated(
      int viewId, ScreenCoordinate leftTopCoordinate, double width, double height);

  void onViewAnnotationAnchorCoordinateUpdated(int viewId, Map<String?, Object?>? anchorCoordinate);

  void onViewAnnotationAnchorUpdated(int viewId, ViewAnnotationAnchorConfig anchor);

  void onViewAnnotationVisibilityUpdated(int viewId, bool visible);
}

@FlutterApi()
abstract class OnViewAnnotationTapListener {
  void onViewAnnotationClick(int viewId);
}
