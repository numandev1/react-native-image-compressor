//
//  Compressor.swift
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 30/08/2019.
//  Copyright © 2019 Trunkrs. All rights reserved.
//

import Foundation
import UIKit
import Accelerate
import CoreGraphics

public class Compressor {
    private static func findTargetSize(image: UIImage, maxWidth: Int, maxHeight: Int) -> CGSize {
        let width: CGFloat = image.size.width
        let height: CGFloat = image.size.height

        if (width > height) {
            let newHeight = height / (width / CGFloat(maxWidth))
            return CGSize(width: CGFloat(maxWidth), height: newHeight)
        }

        let newWidth = width / (height / CGFloat(maxHeight))
        return CGSize(width: newWidth, height: CGFloat(maxHeight))
    }

    public static func decodeImage(base64String: String) throws -> UIImage {
        guard let rawData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters) else {
            throw CompressionError.DecodingData
        }
        
        guard let image = UIImage(data: rawData) else {
            throw CompressionError.DecodingData
        }

        return image
    }

    public static func loadImage(path: String) throws -> UIImage {
        guard let image = UIImage(contentsOfFile: path) else {
            throw CompressionError.FileNotFound
        }

        return image
    }
    
    public static func resize(image: UIImage, maxWidth: Int, maxHeight: Int) throws -> UIImage {
        let targetSize = findTargetSize(image: image, maxWidth: maxWidth, maxHeight: maxHeight)
        guard let cgImage = image.cgImage else {
            throw CompressionError.Drawing
        }
        
        var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil,
                             bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.first.rawValue),
                             version: 0, decode: nil, renderingIntent: CGColorRenderingIntent.defaultIntent)
        var sourceBuffer = vImage_Buffer()
        
        defer {
            sourceBuffer.data.deallocate()
        }
        
        var actionResult = vImageBuffer_InitWithCGImage(&sourceBuffer, &format, nil, cgImage, numericCast(kvImageNoFlags))
        guard actionResult == kvImageNoError else {
            throw CompressionError.Drawing
        }
        
        let destWidth = Int(targetSize.width)
        let destHeight = Int(targetSize.height)
        let bytesPerPixel = cgImage.bitsPerPixel / 8
        let destBytesPerRow = destWidth * bytesPerPixel
        
        var destData = UnsafeMutablePointer<UInt8>.allocate(capacity: destHeight * destBytesPerRow)
        defer {
            destData.deallocate()
        }
        
        var destBuffer = vImage_Buffer(data: &destData, height: vImagePixelCount(destHeight), width: vImagePixelCount(destWidth), rowBytes: destBytesPerRow)
        
        actionResult = vImageScale_ARGB8888(&sourceBuffer, &destBuffer, nil, numericCast(kvImageHighQualityResampling))
        guard actionResult == kvImageNoError else {
            throw CompressionError.Drawing
        }
        
        let resultCGImage = vImageCreateCGImageFromBuffer(&destBuffer, &format, nil, nil, numericCast(kvImageNoFlags), &actionResult)?.takeRetainedValue()
        guard actionResult == kvImageNoError else {
            throw CompressionError.Drawing
        }
        
        let resultImage = resultCGImage.flatMap { UIImage(cgImage: $0, scale: 0.0, orientation: image.imageOrientation) }
        return resultImage!
    }

    static func compress(
        image: UIImage,
        output: CompressorOptions.OutputType,
        quality: Float = 1) throws -> String {
        
        var data: Data?
        
        switch output {
        case .JPG:
            data = image.jpegData(compressionQuality: CGFloat(quality))
        default:
            data = image.pngData()
        }
        
        guard data != nil else {
            throw CompressionError.EncodingData
        }

        return data!.base64EncodedString()
    }

    public enum CompressionError: Error {
        case DecodingData
        case FileNotFound
        case EncodingData
        case Drawing
    }
}
