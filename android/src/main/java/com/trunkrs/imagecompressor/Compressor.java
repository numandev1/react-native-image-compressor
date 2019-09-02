package com.trunkrs.imagecompressor;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.util.Base64;

import com.trunkrs.imagecompressor.util.CompressorOptions;
import com.trunkrs.imagecompressor.util.ImageSize;

import org.jetbrains.annotations.NotNull;

import java.io.ByteArrayOutputStream;

class Compressor {
    static ImageSize findActualSize(@NotNull Bitmap image, int maxWidth, int maxHeight) {
        final float width = (float) image.getWidth();
        final float height = (float) image.getHeight();

        if (width > height) {
            int newHeight = Math.round(height / (width / maxWidth));
            return new ImageSize(maxWidth, newHeight);
        }

        final int newWidth = Math.round(width / (height / maxHeight));
        return new ImageSize(newWidth, maxHeight);
    }

    static Bitmap decodeImage(String value) {
        final byte[] data = Base64.decode(value, Base64.DEFAULT);
        return BitmapFactory.decodeByteArray(data, 0, data.length);
    }

    static Bitmap loadImage(String value) {
        return BitmapFactory.decodeFile(value);
    }

    static String encodeImage(byte[] imageData) {
        return Base64.encodeToString(imageData, Base64.DEFAULT);
    }

    static Bitmap resize(Bitmap image, int maxWidth, int maxHeight) {
        final ImageSize size = findActualSize(image, maxWidth, maxHeight);

        return Bitmap.createScaledBitmap(image, size.width, size.height, false);
    }

    static byte[] compress(Bitmap image, CompressorOptions.OutputType output, float quality) {
        final ByteArrayOutputStream stream = new ByteArrayOutputStream();
        final Bitmap.CompressFormat format = output == CompressorOptions.OutputType.jpg
                ? Bitmap.CompressFormat.JPEG
                : Bitmap.CompressFormat.PNG;

        image.compress(format, Math.round(100 * quality), stream);

        return stream.toByteArray();
    }
}
