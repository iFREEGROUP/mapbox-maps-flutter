// Autogenerated from Pigeon (v17.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

package com.mapbox.maps.mapbox_maps.pigeons

import android.util.Log
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MessageCodec
import io.flutter.plugin.common.StandardMessageCodec
import java.io.ByteArrayOutputStream
import java.nio.ByteBuffer

private fun wrapResult(result: Any?): List<Any?> {
  return listOf(result)
}

private fun wrapError(exception: Throwable): List<Any?> {
  if (exception is ViewAnnotationMessagerFlutterError) {
    return listOf(
      exception.code,
      exception.message,
      exception.details
    )
  } else {
    return listOf(
      exception.javaClass.simpleName,
      exception.toString(),
      "Cause: " + exception.cause + ", Stacktrace: " + Log.getStackTraceString(exception)
    )
  }
}

private fun createConnectionError(channelName: String): ViewAnnotationMessagerFlutterError {
  return ViewAnnotationMessagerFlutterError(
    "channel-error",
    "Unable to establish connection on channel: '$channelName'.",
    ""
  )
}

/**
 * Error class for passing custom error details to Flutter via a thrown PlatformException.
 * @property code The error code.
 * @property message The error message.
 * @property details The error details. Must be a datatype supported by the api codec.
 */
class ViewAnnotationMessagerFlutterError(
  val code: String,
  override val message: String? = null,
  val details: Any? = null
) : Throwable()

enum class AnnotatedFeatureType(val raw: Int) {
  GEOMETRY(0),
  ANNOTATED_LAYER_FEATURE(1);

  companion object {
    fun ofRaw(raw: Int): AnnotatedFeatureType? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class ViewAnnotationAnchor(val raw: Int) {
  CENTER(0),
  TOP(1),
  LEFT(2),
  BOTTOM(3),
  RIGHT(4),
  TOP_LEFT(5),
  BOTTOM_RIGHT(6),
  TOP_RIGHT(7),
  BOTTOM_LEFT(8);

  companion object {
    fun ofRaw(raw: Int): ViewAnnotationAnchor? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

enum class ViewAnnotationUpdateMode(val raw: Int) {
  MAP_FIXED_DELAY(0),
  MAP_SYNCHRONIZED(1);

  companion object {
    fun ofRaw(raw: Int): ViewAnnotationUpdateMode? {
      return values().firstOrNull { it.raw == raw }
    }
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AnnotatedFeature(
  val value: Any,
  val type: AnnotatedFeatureType

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): AnnotatedFeature {
      val value = list[0] as Any
      val type = AnnotatedFeatureType.ofRaw(list[1] as Int)!!
      return AnnotatedFeature(value, type)
    }
  }

  fun toList(): List<Any?> {
    return listOf<Any?>(
      value,
      type.raw,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class ViewAnnotationAnchorConfig(
  val anchor: ViewAnnotationAnchor,
  val offsetX: Double,
  val offsetY: Double

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): ViewAnnotationAnchorConfig {
      val anchor = ViewAnnotationAnchor.ofRaw(list[0] as Int)!!
      val offsetX = list[1] as Double
      val offsetY = list[2] as Double
      return ViewAnnotationAnchorConfig(anchor, offsetX, offsetY)
    }
  }

  fun toList(): List<Any?> {
    return listOf<Any?>(
      anchor.raw,
      offsetX,
      offsetY,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class ViewAnnotationOptions(
  val annotatedFeature: AnnotatedFeature? = null,
  val width: Double? = null,
  val height: Double? = null,
  val allowOverlap: Boolean? = null,
  val allowOverlapWithPuck: Boolean? = null,
  val visible: Boolean? = null,
  val variableAnchors: List<ViewAnnotationAnchorConfig?>? = null,
  val selected: Boolean? = null,
  val ignoreCameraPadding: Boolean? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): ViewAnnotationOptions {
      val annotatedFeature: AnnotatedFeature? = (list[0] as List<Any?>?)?.let {
        AnnotatedFeature.fromList(it)
      }
      val width = list[1] as Double?
      val height = list[2] as Double?
      val allowOverlap = list[3] as Boolean?
      val allowOverlapWithPuck = list[4] as Boolean?
      val visible = list[5] as Boolean?
      val variableAnchors = list[6] as List<ViewAnnotationAnchorConfig?>?
      val selected = list[7] as Boolean?
      val ignoreCameraPadding = list[8] as Boolean?
      return ViewAnnotationOptions(
        annotatedFeature,
        width,
        height,
        allowOverlap,
        allowOverlapWithPuck,
        visible,
        variableAnchors,
        selected,
        ignoreCameraPadding
      )
    }
  }

  fun toList(): List<Any?> {
    return listOf<Any?>(
      annotatedFeature?.toList(),
      width,
      height,
      allowOverlap,
      allowOverlapWithPuck,
      visible,
      variableAnchors,
      selected,
      ignoreCameraPadding,
    )
  }
}

/** Generated class from Pigeon that represents data sent in messages. */
data class AnnotatedLayerFeature(
  val layerId: String,
  val featureId: String? = null

) {
  companion object {
    @Suppress("UNCHECKED_CAST")
    fun fromList(list: List<Any?>): AnnotatedLayerFeature {
      val layerId = list[0] as String
      val featureId = list[1] as String?
      return AnnotatedLayerFeature(layerId, featureId)
    }
  }

  fun toList(): List<Any?> {
    return listOf<Any?>(
      layerId,
      featureId,
    )
  }
}

@Suppress("UNCHECKED_CAST")
private object ViewAnnotationManagerCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AnnotatedFeature.fromList(it)
        }
      }

      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AnnotatedLayerFeature.fromList(it)
        }
      }

      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          ViewAnnotationAnchorConfig.fromList(it)
        }
      }

      131.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          ViewAnnotationOptions.fromList(it)
        }
      }

      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          ViewAnnotationOptions.fromList(it)
        }
      }

      else -> super.readValueOfType(type, buffer)
    }
  }

  override fun writeValue(stream: ByteArrayOutputStream, value: Any?) {
    when (value) {
      is AnnotatedFeature -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }

      is AnnotatedLayerFeature -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }

      is ViewAnnotationAnchorConfig -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }

      is ViewAnnotationOptions -> {
        stream.write(131)
        writeValue(stream, value.toList())
      }

      is ViewAnnotationOptions -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }

      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated interface from Pigeon that represents a handler of messages from Flutter. */
interface ViewAnnotationManager {
  fun addViewAnnotation(
    data: ByteArray,
    options: ViewAnnotationOptions,
    callback: (Result<Long>) -> Unit
  )

  fun removeAllViewAnnotations(callback: (Result<Unit>) -> Unit)
  fun removeViewAnnotation(viewId: Long, callback: (Result<Unit>) -> Unit)
  fun updateViewAnnotation(
    viewId: Long,
    options: ViewAnnotationOptions,
    data: ByteArray?,
    callback: (Result<Boolean>) -> Unit
  )

  fun getViewAnnotationOptions(
    annotatedLayerFeature: AnnotatedLayerFeature,
    callback: (Result<ViewAnnotationOptions?>) -> Unit
  )

  fun getViewAnnotationOptionsByViewId(
    viewId: Long,
    callback: (Result<ViewAnnotationOptions?>) -> Unit
  )

  fun setViewAnnotationUpdateMode(mode: ViewAnnotationUpdateMode, callback: (Result<Unit>) -> Unit)
  fun getViewAnnotationUpdateMode(callback: (Result<ViewAnnotationUpdateMode>) -> Unit)

  companion object {
    /** The codec used by ViewAnnotationManager. */
    val codec: MessageCodec<Any?> by lazy {
      ViewAnnotationManagerCodec
    }

    /** Sets up an instance of `ViewAnnotationManager` to handle messages through the `binaryMessenger`. */
    @Suppress("UNCHECKED_CAST")
    fun setUp(binaryMessenger: BinaryMessenger, api: ViewAnnotationManager?) {
      run {
        val channel = BasicMessageChannel<Any?>(
          binaryMessenger,
          "dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.addViewAnnotation",
          codec
        )
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val dataArg = args[0] as ByteArray
            val optionsArg = args[1] as ViewAnnotationOptions
            api.addViewAnnotation(dataArg, optionsArg) { result: Result<Long> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(
          binaryMessenger,
          "dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.removeAllViewAnnotations",
          codec
        )
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.removeAllViewAnnotations() { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(
          binaryMessenger,
          "dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.removeViewAnnotation",
          codec
        )
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val viewIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            api.removeViewAnnotation(viewIdArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(
          binaryMessenger,
          "dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.updateViewAnnotation",
          codec
        )
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val viewIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            val optionsArg = args[1] as ViewAnnotationOptions
            val dataArg = args[2] as ByteArray?
            api.updateViewAnnotation(viewIdArg, optionsArg, dataArg) { result: Result<Boolean> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(
          binaryMessenger,
          "dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationOptions",
          codec
        )
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val annotatedLayerFeatureArg = args[0] as AnnotatedLayerFeature
            api.getViewAnnotationOptions(annotatedLayerFeatureArg) { result: Result<ViewAnnotationOptions?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(
          binaryMessenger,
          "dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationOptionsByViewId",
          codec
        )
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val viewIdArg = args[0].let { if (it is Int) it.toLong() else it as Long }
            api.getViewAnnotationOptionsByViewId(viewIdArg) { result: Result<ViewAnnotationOptions?> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(
          binaryMessenger,
          "dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.setViewAnnotationUpdateMode",
          codec
        )
        if (api != null) {
          channel.setMessageHandler { message, reply ->
            val args = message as List<Any?>
            val modeArg = ViewAnnotationUpdateMode.ofRaw(args[0] as Int)!!
            api.setViewAnnotationUpdateMode(modeArg) { result: Result<Unit> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                reply.reply(wrapResult(null))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
      run {
        val channel = BasicMessageChannel<Any?>(
          binaryMessenger,
          "dev.flutter.pigeon.mapbox_maps_flutter.ViewAnnotationManager.getViewAnnotationUpdateMode",
          codec
        )
        if (api != null) {
          channel.setMessageHandler { _, reply ->
            api.getViewAnnotationUpdateMode() { result: Result<ViewAnnotationUpdateMode> ->
              val error = result.exceptionOrNull()
              if (error != null) {
                reply.reply(wrapError(error))
              } else {
                val data = result.getOrNull()
                reply.reply(wrapResult(data!!.raw))
              }
            }
          }
        } else {
          channel.setMessageHandler(null)
        }
      }
    }
  }
}

@Suppress("UNCHECKED_CAST")
private object OnViewAnnotationUpdatedListenerCodec : StandardMessageCodec() {
  override fun readValueOfType(type: Byte, buffer: ByteBuffer): Any? {
    return when (type) {
      128.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AnnotatedFeature.fromList(it)
        }
      }

      129.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          AnnotatedLayerFeature.fromList(it)
        }
      }

      130.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          ScreenCoordinate.fromList(it)
        }
      }

      131.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          ViewAnnotationAnchorConfig.fromList(it)
        }
      }

      132.toByte() -> {
        return (readValue(buffer) as? List<Any?>)?.let {
          ViewAnnotationOptions.fromList(it)
        }
      }

      else -> super.readValueOfType(type, buffer)
    }
  }

  override fun writeValue(stream: ByteArrayOutputStream, value: Any?) {
    when (value) {
      is AnnotatedFeature -> {
        stream.write(128)
        writeValue(stream, value.toList())
      }

      is AnnotatedLayerFeature -> {
        stream.write(129)
        writeValue(stream, value.toList())
      }

      is ScreenCoordinate -> {
        stream.write(130)
        writeValue(stream, value.toList())
      }

      is ViewAnnotationAnchorConfig -> {
        stream.write(131)
        writeValue(stream, value.toList())
      }

      is ViewAnnotationOptions -> {
        stream.write(132)
        writeValue(stream, value.toList())
      }

      else -> super.writeValue(stream, value)
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class OnViewAnnotationUpdatedListener(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by OnViewAnnotationUpdatedListener. */
    val codec: MessageCodec<Any?> by lazy {
      OnViewAnnotationUpdatedListenerCodec
    }
  }

  fun onViewAnnotationPositionUpdated(
    viewIdArg: Long,
    leftTopCoordinateArg: ScreenCoordinate,
    widthArg: Double,
    heightArg: Double,
    callback: (Result<Unit>) -> Unit
  ) {
    val channelName =
      "dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationPositionUpdated"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(viewIdArg, leftTopCoordinateArg, widthArg, heightArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(
            Result.failure(
              ViewAnnotationMessagerFlutterError(
                it[0] as String,
                it[1] as String,
                it[2] as String?
              )
            )
          )
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      }
    }
  }

  fun onViewAnnotationAnchorCoordinateUpdated(
    viewIdArg: Long,
    anchorCoordinateArg: Map<String?, Any?>?,
    callback: (Result<Unit>) -> Unit
  ) {
    val channelName =
      "dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorCoordinateUpdated"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(viewIdArg, anchorCoordinateArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(
            Result.failure(
              ViewAnnotationMessagerFlutterError(
                it[0] as String,
                it[1] as String,
                it[2] as String?
              )
            )
          )
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      }
    }
  }

  fun onViewAnnotationAnchorUpdated(
    viewIdArg: Long,
    anchorArg: ViewAnnotationAnchorConfig,
    callback: (Result<Unit>) -> Unit
  ) {
    val channelName =
      "dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationAnchorUpdated"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(viewIdArg, anchorArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(
            Result.failure(
              ViewAnnotationMessagerFlutterError(
                it[0] as String,
                it[1] as String,
                it[2] as String?
              )
            )
          )
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      }
    }
  }

  fun onViewAnnotationVisibilityUpdated(
    viewIdArg: Long,
    visibleArg: Boolean,
    callback: (Result<Unit>) -> Unit
  ) {
    val channelName =
      "dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationUpdatedListener.onViewAnnotationVisibilityUpdated"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(viewIdArg, visibleArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(
            Result.failure(
              ViewAnnotationMessagerFlutterError(
                it[0] as String,
                it[1] as String,
                it[2] as String?
              )
            )
          )
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      }
    }
  }
}

/** Generated class from Pigeon that represents Flutter messages that can be called from Kotlin. */
@Suppress("UNCHECKED_CAST")
class OnViewAnnotationTapListener(private val binaryMessenger: BinaryMessenger) {
  companion object {
    /** The codec used by OnViewAnnotationTapListener. */
    val codec: MessageCodec<Any?> by lazy {
      StandardMessageCodec()
    }
  }

  fun onViewAnnotationClick(viewIdArg: Long, callback: (Result<Unit>) -> Unit) {
    val channelName =
      "dev.flutter.pigeon.mapbox_maps_flutter.OnViewAnnotationTapListener.onViewAnnotationClick"
    val channel = BasicMessageChannel<Any?>(binaryMessenger, channelName, codec)
    channel.send(listOf(viewIdArg)) {
      if (it is List<*>) {
        if (it.size > 1) {
          callback(
            Result.failure(
              ViewAnnotationMessagerFlutterError(
                it[0] as String,
                it[1] as String,
                it[2] as String?
              )
            )
          )
        } else {
          callback(Result.success(Unit))
        }
      } else {
        callback(Result.failure(createConnectionError(channelName)))
      }
    }
  }
}