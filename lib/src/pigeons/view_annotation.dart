part of mapbox_maps_flutter;

enum AnnotatedFeatureType {
  GEOMETRY,
  ANNOTATED_LAYER_FEATURE,
}

enum ViewAnnotationAnchor {
  CENTER,
  TOP,
  LEFT,
  BOTTOM,
  RIGHT,
  TOP_LEFT,
  BOTTOM_RIGHT,
  TOP_RIGHT,
  BOTTOM_LEFT,
}

enum ViewAnnotationUpdateMode {
  MAP_FIXED_DELAY,
  MAP_SYNCHRONIZED,
}

class AnnotatedFeature {
  AnnotatedFeature({
    required this.value,
    required this.type,
  });

  Object value;

  AnnotatedFeatureType type;

  Object encode() {
    return <Object?>[
      value,
      type.index,
    ];
  }

  static AnnotatedFeature decode(Object result) {
    result as List<Object?>;
    return AnnotatedFeature(
      value: result[0]!,
      type: AnnotatedFeatureType.values[result[1]! as int],
    );
  }
}

class ViewAnnotationAnchorConfig {
  ViewAnnotationAnchorConfig({
    required this.anchor,
    required this.offsetX,
    required this.offsetY,
  });

  ViewAnnotationAnchor anchor;

  double offsetX;

  double offsetY;

  Object encode() {
    return <Object?>[
      anchor.index,
      offsetX,
      offsetY,
    ];
  }

  static ViewAnnotationAnchorConfig decode(Object result) {
    result as List<Object?>;
    return ViewAnnotationAnchorConfig(
      anchor: ViewAnnotationAnchor.values[result[0]! as int],
      offsetX: result[1]! as double,
      offsetY: result[2]! as double,
    );
  }
}

class ViewAnnotationOptions {
  ViewAnnotationOptions({
    this.annotatedFeature,
    this.width,
    this.height,
    this.allowOverlap,
    this.allowOverlapWithPuck,
    this.visible,
    this.variableAnchors,
    this.selected,
    this.ignoreCameraPadding,
  });

  AnnotatedFeature? annotatedFeature;

  double? width;

  double? height;

  bool? allowOverlap;

  bool? allowOverlapWithPuck;

  bool? visible;

  List<ViewAnnotationAnchorConfig?>? variableAnchors;

  bool? selected;

  bool? ignoreCameraPadding;

  Object encode() {
    return <Object?>[
      annotatedFeature?.encode(),
      width,
      height,
      allowOverlap,
      allowOverlapWithPuck,
      visible,
      variableAnchors,
      selected,
      ignoreCameraPadding,
    ];
  }

  static ViewAnnotationOptions decode(Object result) {
    result as List<Object?>;
    return ViewAnnotationOptions(
      annotatedFeature:
          result[0] != null ? AnnotatedFeature.decode(result[0]! as List<Object?>) : null,
      width: result[1] as double?,
      height: result[2] as double?,
      allowOverlap: result[3] as bool?,
      allowOverlapWithPuck: result[4] as bool?,
      visible: result[5] as bool?,
      variableAnchors: (result[6] as List<Object?>?)?.cast<ViewAnnotationAnchorConfig?>(),
      selected: result[7] as bool?,
      ignoreCameraPadding: result[8] as bool?,
    );
  }
}

class AnnotatedLayerFeature {
  AnnotatedLayerFeature({
    required this.layerId,
    this.featureId,
  });

  String layerId;

  String? featureId;

  Object encode() {
    return <Object?>[
      layerId,
      featureId,
    ];
  }

  static AnnotatedLayerFeature decode(Object result) {
    result as List<Object?>;
    return AnnotatedLayerFeature(
      layerId: result[0]! as String,
      featureId: result[1] as String?,
    );
  }
}

class _ViewAnnotationManagerCodec extends StandardMessageCodec {
  const _ViewAnnotationManagerCodec();

  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AnnotatedFeature) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is AnnotatedLayerFeature) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is ViewAnnotationAnchorConfig) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is ViewAnnotationOptions) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is ViewAnnotationOptions) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return AnnotatedFeature.decode(readValue(buffer)!);
      case 129:
        return AnnotatedLayerFeature.decode(readValue(buffer)!);
      case 130:
        return ViewAnnotationAnchorConfig.decode(readValue(buffer)!);
      case 131:
        return ViewAnnotationOptions.decode(readValue(buffer)!);
      case 132:
        return ViewAnnotationOptions.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class ViewAnnotationManager {
  /// Constructor for [ViewAnnotationManager].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  ViewAnnotationManager({BinaryMessenger? binaryMessenger})
      : __pigeon_binaryMessenger = binaryMessenger;
  final BinaryMessenger? __pigeon_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _ViewAnnotationManagerCodec();

  Future<int> addViewAnnotation(Uint8List data, ViewAnnotationOptions options) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.addViewAnnotation';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[data, options]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as int?)!;
    }
  }

  Future<void> removeAllViewAnnotations() async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.removeAllViewAnnotations';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel.send(null) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> removeViewAnnotation(int viewId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.removeViewAnnotation';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[viewId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<bool> updateViewAnnotation(
    int viewId,
    ViewAnnotationOptions options, {
    Uint8List? data,
  }) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.updateViewAnnotation';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[viewId, options, data]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (__pigeon_replyList[0] as bool?)!;
    }
  }

  Future<ViewAnnotationOptions?> getViewAnnotationOptions(
      AnnotatedLayerFeature annotatedLayerFeature) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationOptions';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[annotatedLayerFeature]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as ViewAnnotationOptions?);
    }
  }

  Future<ViewAnnotationOptions?> getViewAnnotationOptionsByViewId(int viewId) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationOptionsByViewId';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[viewId]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return (__pigeon_replyList[0] as ViewAnnotationOptions?);
    }
  }

  Future<void> setViewAnnotationUpdateMode(ViewAnnotationUpdateMode mode) async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.setViewAnnotationUpdateMode';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList =
        await __pigeon_channel.send(<Object?>[mode.index]) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<ViewAnnotationUpdateMode> getViewAnnotationUpdateMode() async {
    const String __pigeon_channelName =
        'dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationUpdateMode';
    final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
      __pigeon_channelName,
      pigeonChannelCodec,
      binaryMessenger: __pigeon_binaryMessenger,
    );
    final List<Object?>? __pigeon_replyList = await __pigeon_channel.send(null) as List<Object?>?;
    if (__pigeon_replyList == null) {
      throw _createConnectionError(__pigeon_channelName);
    } else if (__pigeon_replyList.length > 1) {
      throw PlatformException(
        code: __pigeon_replyList[0]! as String,
        message: __pigeon_replyList[1] as String?,
        details: __pigeon_replyList[2],
      );
    } else if (__pigeon_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return ViewAnnotationUpdateMode.values[__pigeon_replyList[0]! as int];
    }
  }

  Future<void> addOnViewAnnotationUpdatedListener(OnViewAnnotationUpdatedListener listener) async {
    OnViewAnnotationUpdatedListener.setup(listener, binaryMessenger: __pigeon_binaryMessenger!);
  }

  Future<void> addOnViewAnnotationClickListener(OnViewAnnotationTapListener listener) async {
    OnViewAnnotationTapListener.setup(listener, binaryMessenger: __pigeon_binaryMessenger!);
  }
}

class _OnViewAnnotationUpdatedListenerCodec extends StandardMessageCodec {
  const _OnViewAnnotationUpdatedListenerCodec();

  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AnnotatedFeature) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is AnnotatedLayerFeature) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is ScreenCoordinate) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is ViewAnnotationAnchorConfig) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is ViewAnnotationOptions) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return AnnotatedFeature.decode(readValue(buffer)!);
      case 129:
        return AnnotatedLayerFeature.decode(readValue(buffer)!);
      case 130:
        return ScreenCoordinate.decode(readValue(buffer)!);
      case 131:
        return ViewAnnotationAnchorConfig.decode(readValue(buffer)!);
      case 132:
        return ViewAnnotationOptions.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class OnViewAnnotationUpdatedListener {
  static const MessageCodec<Object?> pigeonChannelCodec = _OnViewAnnotationUpdatedListenerCodec();

  void onViewAnnotationPositionUpdated(
      int viewId, ScreenCoordinate leftTopCoordinate, double width, double height);

  void onViewAnnotationAnchorCoordinateUpdated(int viewId, Map<String?, Object?>? anchorCoordinate);

  void onViewAnnotationAnchorUpdated(int viewId, ViewAnnotationAnchorConfig anchor);

  void onViewAnnotationVisibilityUpdated(int viewId, bool visible);

  static void setup(OnViewAnnotationUpdatedListener? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationPositionUpdated',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationPositionUpdated was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_viewId = (args[0] as int?);
          assert(arg_viewId != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationPositionUpdated was null, expected non-null int.');
          final ScreenCoordinate? arg_leftTopCoordinate = (args[1] as ScreenCoordinate?);
          assert(arg_leftTopCoordinate != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationPositionUpdated was null, expected non-null ScreenCoordinate.');
          final double? arg_width = (args[2] as double?);
          assert(arg_width != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationPositionUpdated was null, expected non-null double.');
          final double? arg_height = (args[3] as double?);
          assert(arg_height != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationPositionUpdated was null, expected non-null double.');
          try {
            api.onViewAnnotationPositionUpdated(
                arg_viewId!, arg_leftTopCoordinate!, arg_width!, arg_height!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorCoordinateUpdated',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorCoordinateUpdated was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_viewId = (args[0] as int?);
          assert(arg_viewId != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorCoordinateUpdated was null, expected non-null int.');
          final Map<String?, Object?>? arg_anchorCoordinate =
              (args[1] as Map<Object?, Object?>?)?.cast<String?, Object?>();
          try {
            api.onViewAnnotationAnchorCoordinateUpdated(arg_viewId!, arg_anchorCoordinate);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorUpdated',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorUpdated was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_viewId = (args[0] as int?);
          assert(arg_viewId != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorUpdated was null, expected non-null int.');
          final ViewAnnotationAnchorConfig? arg_anchor = (args[1] as ViewAnnotationAnchorConfig?);
          assert(arg_anchor != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorUpdated was null, expected non-null ViewAnnotationAnchorConfig.');
          try {
            api.onViewAnnotationAnchorUpdated(arg_viewId!, arg_anchor!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationVisibilityUpdated',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationVisibilityUpdated was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_viewId = (args[0] as int?);
          assert(arg_viewId != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationVisibilityUpdated was null, expected non-null int.');
          final bool? arg_visible = (args[1] as bool?);
          assert(arg_visible != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationVisibilityUpdated was null, expected non-null bool.');
          try {
            api.onViewAnnotationVisibilityUpdated(arg_viewId!, arg_visible!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}

abstract class OnViewAnnotationTapListener {
  static const MessageCodec<Object?> pigeonChannelCodec = StandardMessageCodec();

  void onViewAnnotationClick(int viewId);

  static void setup(OnViewAnnotationTapListener? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> __pigeon_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationTapListener.onViewAnnotationClick',
          pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        __pigeon_channel.setMessageHandler(null);
      } else {
        __pigeon_channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationTapListener.onViewAnnotationClick was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_viewId = (args[0] as int?);
          assert(arg_viewId != null,
              'Argument for dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationTapListener.onViewAnnotationClick was null, expected non-null int.');
          try {
            api.onViewAnnotationClick(arg_viewId!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          } catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}
