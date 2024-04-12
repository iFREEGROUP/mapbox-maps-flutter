package com.mapbox.maps.mapbox_maps.snapshot

import android.content.Context
import android.os.Looper
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
import kotlinx.coroutines.runBlocking
import java.util.UUID
import java.util.logging.Handler

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


  private var runnable: Runnable? = null
  private val handler = android.os.Handler(Looper.getMainLooper())

  override fun snapshot(callback: (Result<MbxImage?>) -> Unit) {
    var image: MbxImage? = null
    runnable = Runnable {
      callback(Result.success(image))
      runnable = null
    }
    try {
      mapView.javaClass.classLoader?.loadClass("com.mapbox.maps.renderer.gl.PixelReader")?.let {clz->
        val field = clz.getDeclaredField("supportsPbo")
        field.isAccessible = true
        field.set(null, false)
      }
      mapView.snapshot {
        image = it?.toMbxImage()
        runnable?.apply { handler.postDelayed(this, 500) }
      }
    } catch (t:Throwable){
      mapView.snapshot {
        image = it?.toMbxImage()
        runnable?.apply { handler.postDelayed(this, 500) }
      }
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