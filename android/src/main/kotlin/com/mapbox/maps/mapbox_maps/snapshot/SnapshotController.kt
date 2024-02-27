package com.mapbox.maps.mapbox_maps.snapshot

import android.content.Context
import com.mapbox.maps.MapSnapshotOptions
import com.mapbox.maps.MapView
import com.mapbox.maps.Size
import com.mapbox.maps.SnapshotOverlayOptions
import com.mapbox.maps.SnapshotStyleListener
import com.mapbox.maps.Snapshotter
import com.mapbox.maps.Style
import com.mapbox.maps.mapbox_maps.pigeons.*
import com.mapbox.maps.mapbox_maps.toMbxImage
import io.flutter.plugin.common.BinaryMessenger
import java.util.UUID

interface SnapshotControllerDelegate {
  fun getSnapshotter(id: String): Snapshotter

  fun getContext(): Context

  fun remove(id: String)
}

class SnapshotController(private val mapView: MapView, private val context: Context) :
  _SnapShotManager,
  SnapshotControllerDelegate {

  private val snapshotterMap = mutableMapOf<String, Snapshotter>()
  private lateinit var onSnapshotStyleListener: OnSnapshotStyleListener
  private val snapshotter: SnapshotterManager = SnapshotterManager(this)

  override fun create(
    options: com.mapbox.maps.mapbox_maps.pigeons.MapSnapshotOptions,
    overlayOptions: com.mapbox.maps.mapbox_maps.pigeons.SnapshotOverlayOptions
  ): String {
    val snapshotter =
      Snapshotter(
        context,
        options.toSnapshotOptions(),
        overlayOptions.toSnapshotOverlayOptions()
      ).apply {
        this.setStyleListener(object : SnapshotStyleListener {
          override fun onDidFinishLoadingStyle(style: Style) {
            onSnapshotStyleListener.onDidFinishLoadingStyle {}
          }

          override fun onDidFailLoadingStyle(message: String) {
            onSnapshotStyleListener.onDidFailLoadingStyle(message) {}
          }

          override fun onDidFullyLoadStyle(style: Style) {
            onSnapshotStyleListener.onDidFullyLoadStyle({})
          }

          override fun onStyleImageMissing(imageId: String) {
            onSnapshotStyleListener.onStyleImageMissing(imageId) {}
          }
        })
      }
    val id = UUID.randomUUID().toString().replace("-", "")
    snapshotterMap[id] = snapshotter
    return id
  }

  override fun snapshot(callback: (Result<MbxImage?>) -> Unit) {
    mapView.snapshot {
      callback(Result.success(it?.toMbxImage()))
    }
  }

  private fun com.mapbox.maps.mapbox_maps.pigeons.MapSnapshotOptions.toSnapshotOptions(): MapSnapshotOptions {
    val options = MapSnapshotOptions.Builder()
    options.size(Size(this.size.width.toFloat(), this.size.height.toFloat()))
    options.pixelRatio(this.pixelRatio.toFloat())
    return options.build()
  }

  private fun com.mapbox.maps.mapbox_maps.pigeons.SnapshotOverlayOptions.toSnapshotOverlayOptions(): SnapshotOverlayOptions {
    return SnapshotOverlayOptions(this.showLogo, this.showAttributes)
  }

  override fun getSnapshotter(id: String): Snapshotter {
    if (snapshotterMap[id] == null) {
      throw (Throwable("No Snapshotter found with id: $id"))
    }
    return snapshotterMap[id]!!
  }

  override fun getContext(): Context {
    return context
  }

  override fun remove(id: String) {
    snapshotterMap.remove(id)
  }

  fun setup(messenger: BinaryMessenger) {
    onSnapshotStyleListener = OnSnapshotStyleListener(messenger)
    _SnapShotManager.setUp(messenger, this)
    _SnapshotterMessager.setUp(messenger, snapshotter)
  }

  fun dispose(messenger: BinaryMessenger) {
    _SnapShotManager.setUp(messenger, null)
    _SnapshotterMessager.setUp(messenger, null)
    snapshotterMap.clear()
  }
}