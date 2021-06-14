package com.nomi9995.imagecompressor;

import android.graphics.Bitmap;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;
import com.nomi9995.imagecompressor.utils.ImageCompressorOptions;

import java.io.ByteArrayOutputStream;
import java.io.IOException;

public class TRNReactNativeImageCompressorModule extends ReactContextBaseJavaModule {

    private final ReactApplicationContext reactContext;

    public TRNReactNativeImageCompressorModule(ReactApplicationContext reactContext) {
        super(reactContext);
        this.reactContext = reactContext;
    }

    @Override
    public String getName() {
        return "TRNCompressor";
    }

    @ReactMethod
    public void compress(
            String value,
            ReadableMap optionMap,
            Promise promise) {
         try {
      final ImageCompressorOptions options = ImageCompressorOptions.fromMap(optionMap);
      final Bitmap image = options.input == ImageCompressorOptions.InputType.base64
        ? ImageCompressor.decodeImage(value)
        : ImageCompressor.loadImage(value);

      final Bitmap resizedImage = ImageCompressor.resize(image, options.maxWidth, options.maxHeight);
      final ByteArrayOutputStream imageDataByteArrayOutputStream = ImageCompressor.compress(resizedImage, options.output, options.quality);
      Boolean isBase64=options.returnableOutputType==ImageCompressorOptions.ReturnableOutputType.base64;

      final String returnableResult = ImageCompressor.encodeImage(imageDataByteArrayOutputStream,isBase64,image,options.output.toString(),this.reactContext);

      promise.resolve(returnableResult);
    } catch (Exception ex) {
      promise.reject(ex);
    }
    }
}
