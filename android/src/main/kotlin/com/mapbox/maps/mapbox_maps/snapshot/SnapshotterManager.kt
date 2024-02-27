package com.mapbox.maps.mapbox_maps.snapshot

import com.mapbox.maps.Size
import com.mapbox.maps.mapbox_maps.pigeons.CameraOptions
import com.mapbox.maps.mapbox_maps.pigeons.CameraState
import com.mapbox.maps.mapbox_maps.pigeons.MbxEdgeInsets
import com.mapbox.maps.mapbox_maps.pigeons.MbxImage
import com.mapbox.maps.mapbox_maps.pigeons._SnapshotterMessager
import com.mapbox.maps.mapbox_maps.toCameraOptions
import com.mapbox.maps.mapbox_maps.toCameraState
import com.mapbox.maps.mapbox_maps.toEdgeInsets
import com.mapbox.maps.mapbox_maps.toFLTCameraOptions
import com.mapbox.maps.mapbox_maps.toFLTCoordinateBounds
import com.mapbox.maps.mapbox_maps.toFLTSize
import com.mapbox.maps.mapbox_maps.toMbxImage
import com.mapbox.maps.mapbox_maps.toPoint

class SnapshotterManager(private val delegate: SnapshotControllerDelegate) :
  _SnapshotterMessager {
  override fun cancel(id: String) {
    delegate.getSnapshotter(id).cancel()
  }

  override fun destroy(id: String) {
    delegate.getSnapshotter(id).destroy()
    delegate.remove(id)
  }

  override fun setCamera(id: String, cameraOptions: CameraOptions) {
    delegate.getSnapshotter(id).setCamera(cameraOptions.toCameraOptions(delegate.getContext()))
  }

  override fun setStyleUri(id: String, styleUri: String) {
    delegate.getSnapshotter(id).setStyleUri(styleUri)
  }

  override fun setStyleJson(id: String, styleJson: String) {
    delegate.getSnapshotter(id).setStyleJson(styleJson)
  }

  override fun setSize(id: String, size: com.mapbox.maps.mapbox_maps.pigeons.Size) {
    delegate.getSnapshotter(id).setSize(Size(size.width.toFloat(), size.height.toFloat()))
  }

  override fun cameraForCoordinates(
    id: String,
    coordinates: List<Map<String?, Any?>?>,
    padding: MbxEdgeInsets,
    bearing: Double?,
    pitch: Double?
  ): CameraOptions {
    val cameraOptions = delegate.getSnapshotter(id).cameraForCoordinates(
      coordinates.map { it!!.toPoint() },
      padding.toEdgeInsets(delegate.getContext()),
      bearing ?: 0.0, pitch ?: 0.0,
    )
    return cameraOptions.toFLTCameraOptions(delegate.getContext())
  }

  override fun coordinateBoundsForCamera(
    id: String,
    camera: CameraOptions
  ): com.mapbox.maps.mapbox_maps.pigeons.CoordinateBounds {
    val coordinateBounds = delegate.getSnapshotter(id)
      .coordinateBoundsForCamera(camera.toCameraOptions(delegate.getContext()))
    return coordinateBounds.toFLTCoordinateBounds()
  }

  override fun getCameraState(id: String): CameraState {
    val cameraState = delegate.getSnapshotter(id).getCameraState()
    return cameraState.toCameraState(delegate.getContext())
  }

  override fun getSize(id: String): com.mapbox.maps.mapbox_maps.pigeons.Size {
    val size = delegate.getSnapshotter(id).getSize()
    return size.toFLTSize(delegate.getContext())
  }

  override fun getStyleJson(id: String): String {
    return delegate.getSnapshotter(id).getStyleJson()
  }

  override fun getStyleUri(id: String): String {
    return delegate.getSnapshotter(id).getStyleUri()
  }

  override fun start(id: String, callback: (Result<MbxImage?>) -> Unit) {
    delegate.getSnapshotter(id).start { snapshot, errorMessage ->
      if (errorMessage == null) {
        callback(Result.success(snapshot?.toMbxImage()))
      } else {
        callback(Result.failure(UnknownError(errorMessage)))
      }
    }
  }
}