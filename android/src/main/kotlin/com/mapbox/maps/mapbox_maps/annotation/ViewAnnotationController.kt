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
import com.mapbox.maps.mapbox_maps.pigeons.*
import com.mapbox.maps.mapbox_maps.toAnnotatedLayerFeature
import com.mapbox.maps.mapbox_maps.toFLTScreenCoordinate
import com.mapbox.maps.mapbox_maps.toFLTViewAnnotationAnchorConfig
import com.mapbox.maps.mapbox_maps.toFLTViewAnnotationOptions
import com.mapbox.maps.mapbox_maps.toFLTViewAnnotationUpdateMode
import com.mapbox.maps.mapbox_maps.toMap
import com.mapbox.maps.mapbox_maps.toViewAnnotationOption
import com.mapbox.maps.mapbox_maps.toViewAnnotationUpdateMode
import io.flutter.plugin.common.BinaryMessenger

class ViewAnnotationController(private val context: Context, private val mapView: MapView) :
  ViewAnnotationManager {

  private lateinit var viewAnnotationUpdatedListener: OnViewAnnotationUpdatedListener
  private lateinit var viewAnnotationClickListener: OnViewAnnotationTapListener

  init {
    mapView.viewAnnotationManager.addOnViewAnnotationUpdatedListener(object :
      com.mapbox.maps.viewannotation.OnViewAnnotationUpdatedListener {
      override fun onViewAnnotationAnchorCoordinateUpdated(view: View, anchorCoordinate: Point) {
        viewAnnotationUpdatedListener.onViewAnnotationAnchorCoordinateUpdated(
          view.id.toLong(),
          anchorCoordinate.toMap()
        ) {}
      }

      override fun onViewAnnotationAnchorUpdated(view: View, anchor: ViewAnnotationAnchorConfig) {
        viewAnnotationUpdatedListener.onViewAnnotationAnchorUpdated(
          view.id.toLong(),
          anchor.toFLTViewAnnotationAnchorConfig(),
        ) {}
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
        ) {}
      }

      override fun onViewAnnotationVisibilityUpdated(view: View, visible: Boolean) {
        viewAnnotationUpdatedListener.onViewAnnotationVisibilityUpdated(
          view.id.toLong(),
          visible,
        ) {}
      }
    })
  }

  fun setup(messenger: BinaryMessenger) {
    ViewAnnotationManager.setUp(messenger, this)
    viewAnnotationUpdatedListener = OnViewAnnotationUpdatedListener(messenger)
    viewAnnotationClickListener = OnViewAnnotationTapListener(messenger)
  }

  fun dispose(messenger: BinaryMessenger) {
    ViewAnnotationManager.setUp(messenger, null)
  }


  override fun addViewAnnotation(
    data: ByteArray,
    options: ViewAnnotationOptions,
    callback: (Result<Long>) -> Unit
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
        viewAnnotationClickListener.onViewAnnotationClick(it.id.toLong()) {}
      }
      callback(Result.success(view.id.toLong()))
    }
  }


  override fun removeAllViewAnnotations(callback: (Result<Unit>) -> Unit) {
    mapView.viewAnnotationManager.removeAllViewAnnotations()
    callback(Result.success(Unit))
  }


  override fun getViewAnnotationOptions(
    annotatedLayerFeature: AnnotatedLayerFeature,
    callback: (Result<ViewAnnotationOptions?>) -> Unit
  ) {
    val options =
      mapView.viewAnnotationManager.getViewAnnotationOptions(annotatedLayerFeature.toAnnotatedLayerFeature())
    callback(Result.success(options?.toFLTViewAnnotationOptions()))
  }

  override fun setViewAnnotationUpdateMode(
    mode: ViewAnnotationUpdateMode,
    callback: (Result<Unit>) -> Unit
  ) {
    mapView.viewAnnotationManager.setViewAnnotationUpdateMode(mode.toViewAnnotationUpdateMode())
    callback(Result.success(Unit))
  }

  override fun getViewAnnotationUpdateMode(callback: (Result<ViewAnnotationUpdateMode>) -> Unit) {
    val mode = mapView.viewAnnotationManager.getViewAnnotationUpdateMode()
    callback(Result.success(mode.toFLTViewAnnotationUpdateMode()))
  }

  override fun getViewAnnotationOptionsByViewId(
    viewId: Long,
    callback: (Result<ViewAnnotationOptions?>) -> Unit
  ) {
    try {
      val view = mapView.viewAnnotationManager.annotations.keys.find { it.id == viewId.toInt() }
      if (view == null) {
        callback(Result.success(null))
        return
      }
      val options = mapView.viewAnnotationManager.getViewAnnotationOptions(view)
      callback(Result.success(options?.toFLTViewAnnotationOptions()))
    } catch (e: Exception) {
      callback(Result.failure(e))
    }
  }

  override fun updateViewAnnotation(
    viewId: Long,
    options: ViewAnnotationOptions,
    data: ByteArray?,
    callback: (Result<Boolean>) -> Unit
  ) {
    try {
      val view = mapView.viewAnnotationManager.annotations.keys.find { it.id == viewId.toInt() }
      if (view == null) {
        callback(Result.success(false))
        return
      }
      if (data != null && view is ImageView) {
        view.setImageBitmap(BitmapFactory.decodeByteArray(data, 0, data.size))
      }
      val success =
        mapView.viewAnnotationManager.updateViewAnnotation(view, options.toViewAnnotationOption())
      callback(Result.success(success))
    } catch (e: Exception) {
      callback(Result.failure(e))
    }
  }

  override fun removeViewAnnotation(viewId: Long, callback: (Result<Unit>) -> Unit) {
    try {
      val view = mapView.viewAnnotationManager.annotations.keys.find { it.id == viewId.toInt() }
      if (view == null) {
        callback(Result.success(Unit))
        return
      }
      mapView.viewAnnotationManager.removeViewAnnotation(view)
      callback(Result.success(Unit))
    } catch (e: Exception) {
      callback(Result.failure(e))
    }
  }

}