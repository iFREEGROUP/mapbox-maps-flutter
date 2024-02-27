// Autogenerated from Pigeon (v17.0.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import static java.lang.annotation.ElementType.METHOD;
import static java.lang.annotation.RetentionPolicy.CLASS;

import android.util.Log;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MessageCodec;
import io.flutter.plugin.common.StandardMessageCodec;
import java.io.ByteArrayOutputStream;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/** Generated class from Pigeon. */
@SuppressWarnings({"unused", "unchecked", "CodeBlock2Expr", "RedundantSuppression", "serial"})
public class snapshot_manager {

  /** Error class for passing custom error details to Flutter via a thrown PlatformException. */
  public static class FlutterError extends RuntimeException {

    /** The error code. */
    public final String code;

    /** The error details. Must be a datatype supported by the api codec. */
    public final Object details;

    public FlutterError(@NonNull String code, @Nullable String message, @Nullable Object details) 
    {
      super(message);
      this.code = code;
      this.details = details;
    }
  }

  @NonNull
  protected static ArrayList<Object> wrapError(@NonNull Throwable exception) {
    ArrayList<Object> errorList = new ArrayList<Object>(3);
    if (exception instanceof FlutterError) {
      FlutterError error = (FlutterError) exception;
      errorList.add(error.code);
      errorList.add(error.getMessage());
      errorList.add(error.details);
    } else {
      errorList.add(exception.toString());
      errorList.add(exception.getClass().getSimpleName());
      errorList.add(
        "Cause: " + exception.getCause() + ", Stacktrace: " + Log.getStackTraceString(exception));
    }
    return errorList;
  }

  @Target(METHOD)
  @Retention(CLASS)
  @interface CanIgnoreReturnValue {}

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class Size {
    /** Width of the size. */
    private @NonNull Double width;

    public @NonNull Double getWidth() {
      return width;
    }

    public void setWidth(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"width\" is null.");
      }
      this.width = setterArg;
    }

    /** Height of the size. */
    private @NonNull Double height;

    public @NonNull Double getHeight() {
      return height;
    }

    public void setHeight(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"height\" is null.");
      }
      this.height = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    Size() {}

    public static final class Builder {

      private @Nullable Double width;

      @CanIgnoreReturnValue
      public @NonNull Builder setWidth(@NonNull Double setterArg) {
        this.width = setterArg;
        return this;
      }

      private @Nullable Double height;

      @CanIgnoreReturnValue
      public @NonNull Builder setHeight(@NonNull Double setterArg) {
        this.height = setterArg;
        return this;
      }

      public @NonNull Size build() {
        Size pigeonReturn = new Size();
        pigeonReturn.setWidth(width);
        pigeonReturn.setHeight(height);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(2);
      toListResult.add(width);
      toListResult.add(height);
      return toListResult;
    }

    static @NonNull Size fromList(@NonNull ArrayList<Object> list) {
      Size pigeonResult = new Size();
      Object width = list.get(0);
      pigeonResult.setWidth((Double) width);
      Object height = list.get(1);
      pigeonResult.setHeight((Double) height);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class MapSnapshotOptions {
    private @NonNull Size size;

    public @NonNull Size getSize() {
      return size;
    }

    public void setSize(@NonNull Size setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"size\" is null.");
      }
      this.size = setterArg;
    }

    private @NonNull Double pixelRatio;

    public @NonNull Double getPixelRatio() {
      return pixelRatio;
    }

    public void setPixelRatio(@NonNull Double setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"pixelRatio\" is null.");
      }
      this.pixelRatio = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    MapSnapshotOptions() {}

    public static final class Builder {

      private @Nullable Size size;

      @CanIgnoreReturnValue
      public @NonNull Builder setSize(@NonNull Size setterArg) {
        this.size = setterArg;
        return this;
      }

      private @Nullable Double pixelRatio;

      @CanIgnoreReturnValue
      public @NonNull Builder setPixelRatio(@NonNull Double setterArg) {
        this.pixelRatio = setterArg;
        return this;
      }

      public @NonNull MapSnapshotOptions build() {
        MapSnapshotOptions pigeonReturn = new MapSnapshotOptions();
        pigeonReturn.setSize(size);
        pigeonReturn.setPixelRatio(pixelRatio);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(2);
      toListResult.add((size == null) ? null : size.toList());
      toListResult.add(pixelRatio);
      return toListResult;
    }

    static @NonNull MapSnapshotOptions fromList(@NonNull ArrayList<Object> list) {
      MapSnapshotOptions pigeonResult = new MapSnapshotOptions();
      Object size = list.get(0);
      pigeonResult.setSize((size == null) ? null : Size.fromList((ArrayList<Object>) size));
      Object pixelRatio = list.get(1);
      pigeonResult.setPixelRatio((Double) pixelRatio);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class SnapshotOverlayOptions {
    private @NonNull Boolean showLogo;

    public @NonNull Boolean getShowLogo() {
      return showLogo;
    }

    public void setShowLogo(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"showLogo\" is null.");
      }
      this.showLogo = setterArg;
    }

    private @NonNull Boolean showAttributes;

    public @NonNull Boolean getShowAttributes() {
      return showAttributes;
    }

    public void setShowAttributes(@NonNull Boolean setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"showAttributes\" is null.");
      }
      this.showAttributes = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    SnapshotOverlayOptions() {}

    public static final class Builder {

      private @Nullable Boolean showLogo;

      @CanIgnoreReturnValue
      public @NonNull Builder setShowLogo(@NonNull Boolean setterArg) {
        this.showLogo = setterArg;
        return this;
      }

      private @Nullable Boolean showAttributes;

      @CanIgnoreReturnValue
      public @NonNull Builder setShowAttributes(@NonNull Boolean setterArg) {
        this.showAttributes = setterArg;
        return this;
      }

      public @NonNull SnapshotOverlayOptions build() {
        SnapshotOverlayOptions pigeonReturn = new SnapshotOverlayOptions();
        pigeonReturn.setShowLogo(showLogo);
        pigeonReturn.setShowAttributes(showAttributes);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(2);
      toListResult.add(showLogo);
      toListResult.add(showAttributes);
      return toListResult;
    }

    static @NonNull SnapshotOverlayOptions fromList(@NonNull ArrayList<Object> list) {
      SnapshotOverlayOptions pigeonResult = new SnapshotOverlayOptions();
      Object showLogo = list.get(0);
      pigeonResult.setShowLogo((Boolean) showLogo);
      Object showAttributes = list.get(1);
      pigeonResult.setShowAttributes((Boolean) showAttributes);
      return pigeonResult;
    }
  }

  /** Generated class from Pigeon that represents data sent in messages. */
  public static final class MbxImage {
    /** The width of the image, in screen pixels. */
    private @NonNull Long width;

    public @NonNull Long getWidth() {
      return width;
    }

    public void setWidth(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"width\" is null.");
      }
      this.width = setterArg;
    }

    /** The height of the image, in screen pixels. */
    private @NonNull Long height;

    public @NonNull Long getHeight() {
      return height;
    }

    public void setHeight(@NonNull Long setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"height\" is null.");
      }
      this.height = setterArg;
    }

    /**
     * 32-bit premultiplied RGBA image data.
     *
     * An uncompressed image data encoded in 32-bit RGBA format with premultiplied
     * alpha channel. This field should contain exactly `4 * width * height` bytes. It
     * should consist of a sequence of scanlines.
     */
    private @NonNull byte[] data;

    public @NonNull byte[] getData() {
      return data;
    }

    public void setData(@NonNull byte[] setterArg) {
      if (setterArg == null) {
        throw new IllegalStateException("Nonnull field \"data\" is null.");
      }
      this.data = setterArg;
    }

    /** Constructor is non-public to enforce null safety; use Builder. */
    MbxImage() {}

    public static final class Builder {

      private @Nullable Long width;

      @CanIgnoreReturnValue
      public @NonNull Builder setWidth(@NonNull Long setterArg) {
        this.width = setterArg;
        return this;
      }

      private @Nullable Long height;

      @CanIgnoreReturnValue
      public @NonNull Builder setHeight(@NonNull Long setterArg) {
        this.height = setterArg;
        return this;
      }

      private @Nullable byte[] data;

      @CanIgnoreReturnValue
      public @NonNull Builder setData(@NonNull byte[] setterArg) {
        this.data = setterArg;
        return this;
      }

      public @NonNull MbxImage build() {
        MbxImage pigeonReturn = new MbxImage();
        pigeonReturn.setWidth(width);
        pigeonReturn.setHeight(height);
        pigeonReturn.setData(data);
        return pigeonReturn;
      }
    }

    @NonNull
    ArrayList<Object> toList() {
      ArrayList<Object> toListResult = new ArrayList<Object>(3);
      toListResult.add(width);
      toListResult.add(height);
      toListResult.add(data);
      return toListResult;
    }

    static @NonNull MbxImage fromList(@NonNull ArrayList<Object> list) {
      MbxImage pigeonResult = new MbxImage();
      Object width = list.get(0);
      pigeonResult.setWidth((width == null) ? null : ((width instanceof Integer) ? (Integer) width : (Long) width));
      Object height = list.get(1);
      pigeonResult.setHeight((height == null) ? null : ((height instanceof Integer) ? (Integer) height : (Long) height));
      Object data = list.get(2);
      pigeonResult.setData((byte[]) data);
      return pigeonResult;
    }
  }

  /** Asynchronous error handling return type for non-nullable API method returns. */
  public interface Result<T> {
    /** Success case callback method for handling returns. */
    void success(@NonNull T result);

    /** Failure case callback method for handling errors. */
    void error(@NonNull Throwable error);
  }
  /** Asynchronous error handling return type for nullable API method returns. */
  public interface NullableResult<T> {
    /** Success case callback method for handling returns. */
    void success(@Nullable T result);

    /** Failure case callback method for handling errors. */
    void error(@NonNull Throwable error);
  }
  /** Asynchronous error handling return type for void API method returns. */
  public interface VoidResult {
    /** Success case callback method for handling returns. */
    void success();

    /** Failure case callback method for handling errors. */
    void error(@NonNull Throwable error);
  }

  private static class _SnapShotManagerCodec extends StandardMessageCodec {
    public static final _SnapShotManagerCodec INSTANCE = new _SnapShotManagerCodec();

    private _SnapShotManagerCodec() {}

    @Override
    protected Object readValueOfType(byte type, @NonNull ByteBuffer buffer) {
      switch (type) {
        case (byte) 128:
          return MapSnapshotOptions.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 129:
          return MbxImage.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 130:
          return Size.fromList((ArrayList<Object>) readValue(buffer));
        case (byte) 131:
          return SnapshotOverlayOptions.fromList((ArrayList<Object>) readValue(buffer));
        default:
          return super.readValueOfType(type, buffer);
      }
    }

    @Override
    protected void writeValue(@NonNull ByteArrayOutputStream stream, Object value) {
      if (value instanceof MapSnapshotOptions) {
        stream.write(128);
        writeValue(stream, ((MapSnapshotOptions) value).toList());
      } else if (value instanceof MbxImage) {
        stream.write(129);
        writeValue(stream, ((MbxImage) value).toList());
      } else if (value instanceof Size) {
        stream.write(130);
        writeValue(stream, ((Size) value).toList());
      } else if (value instanceof SnapshotOverlayOptions) {
        stream.write(131);
        writeValue(stream, ((SnapshotOverlayOptions) value).toList());
      } else {
        super.writeValue(stream, value);
      }
    }
  }

  /** Generated interface from Pigeon that represents a handler of messages from Flutter. */
  public interface _SnapShotManager {

    @NonNull 
    String create(@NonNull MapSnapshotOptions options, @NonNull SnapshotOverlayOptions overlayOptions);

    void snapshot(@NonNull NullableResult<MbxImage> result);

    /** The codec used by _SnapShotManager. */
    static @NonNull MessageCodec<Object> getCodec() {
      return _SnapShotManagerCodec.INSTANCE;
    }
    /**Sets up an instance of `_SnapShotManager` to handle messages through the `binaryMessenger`. */
    static void setUp(@NonNull BinaryMessenger binaryMessenger, @Nullable _SnapShotManager api) {
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.mapbox_maps_flutter._SnapShotManager.create", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                ArrayList<Object> args = (ArrayList<Object>) message;
                MapSnapshotOptions optionsArg = (MapSnapshotOptions) args.get(0);
                SnapshotOverlayOptions overlayOptionsArg = (SnapshotOverlayOptions) args.get(1);
                try {
                  String output = api.create(optionsArg, overlayOptionsArg);
                  wrapped.add(0, output);
                }
 catch (Throwable exception) {
                  ArrayList<Object> wrappedError = wrapError(exception);
                  wrapped = wrappedError;
                }
                reply.reply(wrapped);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
      {
        BasicMessageChannel<Object> channel =
            new BasicMessageChannel<>(
                binaryMessenger, "dev.flutter.pigeon.mapbox_maps_flutter._SnapShotManager.snapshot", getCodec());
        if (api != null) {
          channel.setMessageHandler(
              (message, reply) -> {
                ArrayList<Object> wrapped = new ArrayList<Object>();
                NullableResult<MbxImage> resultCallback =
                    new NullableResult<MbxImage>() {
                      public void success(MbxImage result) {
                        wrapped.add(0, result);
                        reply.reply(wrapped);
                      }

                      public void error(Throwable error) {
                        ArrayList<Object> wrappedError = wrapError(error);
                        reply.reply(wrappedError);
                      }
                    };

                api.snapshot(resultCallback);
              });
        } else {
          channel.setMessageHandler(null);
        }
      }
    }
  }
}
