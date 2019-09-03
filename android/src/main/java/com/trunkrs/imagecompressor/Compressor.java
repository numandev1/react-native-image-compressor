package com.trunkrs.imagecompressor;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.util.Base64;

import com.trunkrs.imagecompressor.util.CompressorOptions;
import com.trunkrs.imagecompressor.util.ImageSize;

import java.io.ByteArrayOutputStream;

class Compressor {
    static ImageSize findActualSize(Bitmap image, int maxWidth, int maxHeight) {
        final float width = (float) image.getWidth();
        final float height = (float) image.getHeight();

        if (width > height) {
            final int newHeight = Math.round(height / (width / maxWidth));
            final float scale = newHeight / height;

            return new ImageSize(maxWidth, newHeight, scale);
        }

        final int newWidth = Math.round(width / (height / maxHeight));
        final float scale = newWidth / width;

        return new ImageSize(newWidth, maxHeight, scale);
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

        final Bitmap scaledImage = Bitmap.createBitmap(size.width, size.height, image.getConfig());
        final Matrix scaleMatrix = new Matrix();
        final Canvas canvas = new Canvas(scaledImage);
        final Paint paint = new Paint(Paint.FILTER_BITMAP_FLAG);

        scaleMatrix.setScale(size.scale, size.scale, 0 ,0);

        paint.setDither(true);
        paint.setAntiAlias(true);
        paint.setFilterBitmap(true);

        canvas.drawBitmap(image, scaleMatrix, paint);

        return scaledImage;
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
