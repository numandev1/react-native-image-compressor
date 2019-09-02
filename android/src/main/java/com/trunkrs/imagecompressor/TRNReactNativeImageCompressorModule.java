package com.trunkrs.imagecompressor;

import android.graphics.Bitmap;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;
import com.trunkrs.imagecompressor.util.CompressorOptions;

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
            final CompressorOptions options = CompressorOptions.fromMap(optionMap);
            final Bitmap image = options.input == CompressorOptions.InputType.base64
                    ? Compressor.decodeImage(value)
                    : Compressor.loadImage(value);

            final Bitmap resizedImage = Compressor.resize(image, options.maxWidth, options.maxHeight);
            final byte[] imageData = Compressor.compress(resizedImage, options.output, options.quality);
            final String base64Result = Compressor.encodeImage(imageData);

            promise.resolve(base64Result);
        } catch (Exception ex) {
            promise.reject(ex);
        }
    }
}
