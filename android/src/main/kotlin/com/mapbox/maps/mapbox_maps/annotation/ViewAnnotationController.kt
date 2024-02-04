package com.mapbox.maps.mapbox_maps.annotation

import android.content.Context
import android.graphics.BitmapFactory
import android.view.LayoutInflater
import android.view.View
import android.widget.ImageView
import com.mapbox.geojson.Point
import com.mapbox.maps.MapView
import com.mapbox.maps.ScreenCoordinate
import com.mapbox.maps.ViewAnnotationAnchorConfig
import com.mapbox.maps.mapbox_maps.R
import com.mapbox.maps.mapbox_maps.toAnnotatedLayerFeature
import com.mapbox.maps.mapbox_maps.toFLTScreenCoordinate
import com.mapbox.maps.mapbox_maps.toFLTViewAnnotationAnchorConfig
import com.mapbox.maps.mapbox_maps.toFLTViewAnnotationOptions
import com.mapbox.maps.mapbox_maps.toFLTViewAnnotationUpdateMode
import com.mapbox.maps.mapbox_maps.toMap
import com.mapbox.maps.mapbox_maps.toViewAnnotationOption
import com.mapbox.maps.mapbox_maps.toViewAnnotationUpdateMode
import com.mapbox.maps.pigeons.FLTViewAnnotation
import com.mapbox.maps.pigeons.FLTViewAnnotation.OnViewAnnotationTapListener
import com.mapbox.maps.pigeons.FLTViewAnnotation.OnViewAnnotationUpdatedListener
import com.mapbox.maps.pigeons.FLTViewAnnotation.ViewAnnotationUpdateMode
import com.mapbox.maps.pigeons.FLTViewAnnotation.VoidResult
import io.flutter.plugin.common.BinaryMessenger

class ViewAnnotationController(private val context: Context, private val mapView: MapView) :
  FLTViewAnnotation.ViewAnnotationManager {

  private lateinit var viewAnnotationUpdatedListener: OnViewAnnotationUpdatedListener
  private lateinit var viewAnnotationClickListener: OnViewAnnotationTapListener

  private val voidResult = object : VoidResult {
    override fun success() {}
    override fun error(error: Throwable) {}
  }

  init {
    mapView.viewAnnotationManager.addOnViewAnnotationUpdatedListener(object :
      com.mapbox.maps.viewannotation.OnViewAnnotationUpdatedListener {
      override fun onViewAnnotationAnchorCoordinateUpdated(view: View, anchorCoordinate: Point) {
        viewAnnotationUpdatedListener.onViewAnnotationAnchorCoordinateUpdated(
          view.id.toLong(),
          anchorCoordinate.toMap(),
          voidResult
        )
      }

      override fun onViewAnnotationAnchorUpdated(view: View, anchor: ViewAnnotationAnchorConfig) {
        viewAnnotationUpdatedListener.onViewAnnotationAnchorUpdated(
          view.id.toLong(),
          anchor.toFLTViewAnnotationAnchorConfig(),
          voidResult
        )
      }

      override fun onViewAnnotationPositionUpdated(
        view: View,
        leftTopCoordinate: ScreenCoordinate,
        width: Double,
        height: Double
      ) {
        viewAnnotationUpdatedListener.onViewAnnotationPositionUpdated(
          view.id.toLong(),
          leftTopCoordinate.toFLTScreenCoordinate(context),
          width,
          height,
          voidResult
        )
      }

      override fun onViewAnnotationVisibilityUpdated(view: View, visible: Boolean) {
        viewAnnotationUpdatedListener.onViewAnnotationVisibilityUpdated(
          view.id.toLong(),
          visible,
          voidResult
        )
      }
    })
  }

  fun setup(messenger: BinaryMessenger) {
    FLTViewAnnotation.ViewAnnotationManager.setUp(messenger, this)
    viewAnnotationUpdatedListener = OnViewAnnotationUpdatedListener(messenger)
    viewAnnotationClickListener = OnViewAnnotationTapListener(messenger)
  }

  fun dispose(messenger: BinaryMessenger) {
    FLTViewAnnotation.ViewAnnotationManager.setUp(messenger, null)
  }

  override fun addViewAnnotation(
    data: ByteArray,
    options: FLTViewAnnotation.ViewAnnotationOptions,
    result: FLTViewAnnotation.Result<Long>
  ) {
    mapView.viewAnnotationManager.addViewAnnotation(
      R.layout.view_annotation,
      options.toViewAnnotationOption()
    ).also { view ->
      view.id = View.generateViewId()
      (view as ImageView).apply {
        setImageBitmap(BitmapFactory.decodeByteArray(data, 0, data.size))
      }
      view.setOnClickListener {
        viewAnnotationClickListener.onViewAnnotationClick(it.id.toLong(), voidResult)
      }
      result.success(view.id.toLong())
    }
  }

  override fun removeAllViewAnnotations(result: VoidResult) {
    mapView.viewAnnotationManager.removeAllViewAnnotations()
    result.success()
  }

  override fun getViewAnnotationOptions(
    annotatedLayerFeature: FLTViewAnnotation.AnnotatedLayerFeature,
    result: FLTViewAnnotation.NullableResult<FLTViewAnnotation.ViewAnnotationOptions>
  ) {
    val options =
      mapView.viewAnnotationManager.getViewAnnotationOptions(annotatedLayerFeature.toAnnotatedLayerFeature())
    result.success(options?.toFLTViewAnnotationOptions())
  }

  override fun setViewAnnotationUpdateMode(mode: ViewAnnotationUpdateMode, result: VoidResult) {
    mapView.viewAnnotationManager.setViewAnnotationUpdateMode(mode.toViewAnnotationUpdateMode())
    result.success()
  }

  override fun getViewAnnotationUpdateMode(result: FLTViewAnnotation.Result<ViewAnnotationUpdateMode>) {
    val mode = mapView.viewAnnotationManager.getViewAnnotationUpdateMode()
    result.success(mode.toFLTViewAnnotationUpdateMode())
  }

  override fun getViewAnnotationOptionsByViewId(
    viewId: Long,
    result: FLTViewAnnotation.NullableResult<FLTViewAnnotation.ViewAnnotationOptions>
  ) {
    try {
      val view = mapView.findViewById<View?>(viewId.toInt())
      val options = mapView.viewAnnotationManager.getViewAnnotationOptions(view)
      result.success(options?.toFLTViewAnnotationOptions())
    } catch (e: Exception) {
      result.error(e)
    }
  }

  override fun updateViewAnnotation(
    viewId: Long,
    options: FLTViewAnnotation.ViewAnnotationOptions,
    data: ByteArray?,
    result: FLTViewAnnotation.Result<Boolean>
  ) {
    try {
      val view = mapView.findViewById<ImageView?>(viewId.toInt())
      if (data != null) {
        view.setImageBitmap(BitmapFactory.decodeByteArray(data, 0, data.size))
      }
      val success =
        mapView.viewAnnotationManager.updateViewAnnotation(view, options.toViewAnnotationOption())
      result.success(success)
    } catch (e: Exception) {
      result.error(e)
    }
  }

  override fun removeViewAnnotation(viewId: Long, result: VoidResult) {
    try {
      val view = mapView.findViewById<View?>(viewId.toInt())
      mapView.viewAnnotationManager.removeViewAnnotation(view)
      result.success()
    } catch (e: Exception) {
      result.error(e)
    }
  }

}