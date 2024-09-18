import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mapbox_maps_example/page.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class ViewAnnotationPage extends ExamplePage {
  ViewAnnotationPage() : super(const Icon(Icons.map), 'ViewAnnotation');

  @override
  Widget build(BuildContext context) {
    return ViewAnnotationPageBody();
  }
}

class ViewAnnotationPageBody extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ViewAnnotationPageBodyState();
  }
}

class OnViewAnnotationClickListener extends OnViewAnnotationTapListener {
  final BuildContext context;

  OnViewAnnotationClickListener(this.context);

  @override
  void onViewAnnotationClick(int viewId) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('click view annotation, id: $viewId'),
      backgroundColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 2),
    ));
  }
}

class OnViewAnnotationUpdateListener extends OnViewAnnotationUpdatedListener {
  @override
  void onViewAnnotationAnchorCoordinateUpdated(
      int viewId, Map<String?, Object?>? anchorCoordinate) {
    debugPrint('onViewAnnotationAnchorCoordinateUpdated: $viewId, $anchorCoordinate');
  }

  @override
  void onViewAnnotationAnchorUpdated(int viewId, ViewAnnotationAnchorConfig anchor) {
    debugPrint('onViewAnnotationAnchorUpdated: $viewId, ${json.encode(anchor)}');
  }

  @override
  void onViewAnnotationPositionUpdated(
      int viewId, ScreenCoordinate leftTopCoordinate, double width, double height) {
    debugPrint(
        'onViewAnnotationPositionUpdated: $viewId, ${json.encode(leftTopCoordinate)}, $width, $height');
  }

  @override
  void onViewAnnotationVisibilityUpdated(int viewId, bool visible) {
    debugPrint('onViewAnnotationAnchorUpdated: $viewId, $visible');
  }
}

class ViewAnnotationPageBodyState extends State<ViewAnnotationPageBody> {
  ViewAnnotationPageBodyState();

  MapboxMap? mapboxMap;
  GlobalKey globalKey = GlobalKey();

  _onMapCreated(MapboxMap mapboxMap) {
    this.mapboxMap = mapboxMap;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Uint8List? data;
  PointAnnotation? pointAnnotation;

  Widget _create() {
    return TextButton(
      child: Text('add a anchor point view annotation'),
      onPressed: () async {
        final currentState = await mapboxMap?.getCameraState();
        if (currentState == null) return;

        final boundary = globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
        final ratio = MediaQuery.of(context).devicePixelRatio;
        final image = await boundary?.toImage(pixelRatio: ratio);
        final bytes = await image?.toByteData(format: ImageByteFormat.png);

        data = bytes?.buffer.asUint8List();
        if (data == null) return;

        final manager =
            await mapboxMap?.annotations.createPointAnnotationManager(id: 'pointLayerId');
        pointAnnotation = await manager?.create(PointAnnotationOptions(
          geometry: currentState.center,
          textField: 'point',
          textColor: Colors.red.value,
          textSize: 20,
        ));

        viewAnnotationId = await mapboxMap?.viewAnnotationManager.addViewAnnotation(
          data!,
          ViewAnnotationOptions(
            annotatedFeature: AnnotatedFeature(
              value: AnnotatedLayerFeature(layerId: 'pointLayerId', featureId: pointAnnotation?.id),
              type: AnnotatedFeatureType.ANNOTATED_LAYER_FEATURE,
            ),
            width: 100,
            height: 100,
            variableAnchors: [
              ViewAnnotationAnchorConfig(
                anchor: AnnotationAnchor.BOTTOM_LEFT,
                offsetX: 0,
                offsetY: 0,
              ),
            ],
            allowOverlap: true,
          ),
        );
      },
    );
  }

  Widget createNew() {
    return TextButton(
      child: Text('new one to anchor another direction'),
      onPressed: () async {
        if (data == null) return;
        mapboxMap?.viewAnnotationManager.addViewAnnotation(
          data!,
          ViewAnnotationOptions(
            annotatedFeature: AnnotatedFeature(
              value: AnnotatedLayerFeature(layerId: 'pointLayerId', featureId: pointAnnotation?.id),
              type: AnnotatedFeatureType.ANNOTATED_LAYER_FEATURE,
            ),
            width: 100,
            height: 100,
            variableAnchors: [
              ViewAnnotationAnchorConfig(
                anchor: AnnotationAnchor.TOP_RIGHT,
                offsetX: 0,
                offsetY: 0,
              ),
            ],
            allowOverlap: true,
          ),
        );
      },
    );
  }

  int? viewAnnotationId;

  Widget update() {
    return TextButton(
      child: Text('update viewAnnotation'),
      onPressed: () async {
        if (viewAnnotationId == null) return;

        final old = await mapboxMap?.viewAnnotationManager
            .getViewAnnotationOptionsByViewId(viewAnnotationId!);

        ViewAnnotationAnchorConfig config;

        final random = Random();

        if (old?.variableAnchors?.isNotEmpty == true) {
          final anchor = old!.variableAnchors!.first!.anchor;
          final values = AnnotationAnchor.values.toList()
            ..removeWhere((element) => element == anchor);
          config = ViewAnnotationAnchorConfig(
            anchor: values[random.nextInt(values.length)],
            offsetX: 0,
            offsetY: 0,
          );
        } else {
          config = ViewAnnotationAnchorConfig(
            anchor: AnnotationAnchor.TOP,
            offsetX: 0,
            offsetY: 0,
          );
        }

        mapboxMap?.viewAnnotationManager.updateViewAnnotation(
          viewAnnotationId!,
          ViewAnnotationOptions(variableAnchors: [config]),
        );
      },
    );
  }

  Widget delete() {
    return TextButton(
      child: Text('delete viewAnnotation'),
      onPressed: () async {
        if (viewAnnotationId == null) return;
        mapboxMap?.viewAnnotationManager.removeViewAnnotation(viewAnnotationId!);
        viewAnnotationId = null;
      },
    );
  }

  OnViewAnnotationClickListener? onViewAnnotationClickListener;
  OnViewAnnotationUpdatedListener? onViewAnnotationUpdatedListener;

  Widget addClickListener() {
    return TextButton(
      child: Text('add clickListener'),
      onPressed: () {
        if (onViewAnnotationClickListener != null) {
          return;
        }
        onViewAnnotationClickListener = OnViewAnnotationClickListener(context);
        mapboxMap?.viewAnnotationManager
            .addOnViewAnnotationClickListener(onViewAnnotationClickListener!);
      },
    );
  }

  Widget addUpdateListener() {
    return TextButton(
      onPressed: () {
        if (onViewAnnotationUpdatedListener != null) {
          return;
        }
        onViewAnnotationUpdatedListener = OnViewAnnotationUpdateListener();
        mapboxMap?.viewAnnotationManager.addOnViewAnnotationUpdatedListener(onViewAnnotationUpdatedListener!);
      },
      child: Text('add updateListener'),
    );
  }

  @override
  Widget build(BuildContext context) {
    final MapWidget mapWidget = MapWidget(key: ValueKey("mapWidget"), onMapCreated: _onMapCreated);

    final List<Widget> listViewChildren = <Widget>[];

    listViewChildren.addAll(
      <Widget>[
        _create(),
        createNew(),
        update(),
        delete(),
        addClickListener(),
        addUpdateListener(),
      ],
    );

    final colmn = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 400,
              child: mapWidget),
        ),
        Expanded(
          child: ListView(
            children: listViewChildren,
          ),
        )
      ],
    );

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(child: Icon(Icons.swap_horiz), heroTag: null, onPressed: () {}),
            SizedBox(height: 10),
            FloatingActionButton(child: Icon(Icons.clear), heroTag: null, onPressed: () {}),
          ],
        ),
      ),
      body: Stack(
        children: [
          colmn,
          Positioned(
            left: -1000,
            top: -1000,
            child: RepaintBoundary(
              key: globalKey,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.amber,
                alignment: Alignment.center,
                child: Text('hello ViewAnnotation'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
