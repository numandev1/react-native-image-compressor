//
//  Compressor.swift
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 30/08/2019.
//  Copyright © 2019 Trunkrs. All rights reserved.
//

import Foundation
import UIKit

public class Compressor {
    private static func findTargetSize(image: UIImage, maxWidth: Int, maxHeight: Int) -> CGSize {
        let width: CGFloat = image.size.width
        let height: CGFloat = image.size.height

        if (width > height) {
            let newHeight = height / (width / maxWidth)
            return CGSize(maxWidth, newHeight)
        }

        let newWidth = width / (height / maxHeight)
        return CGSize(newWidth, maxHeight)
    }

    public static func decodeImage(base64String: String) throws -> UIImage {
        let rawData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters)!

        guard rawData else {
            throw CompressionError.DecodingData
        }

        return UIImage(data: rawData)
    }

    public static func loadImage(path: String) throws -> UIImage {
        let rawData = UIImage(contentsOfFile: path)

        guard rawData else {
            throw CompressionError.FileNotFound
        }

        return rawData
    }

    public static func compress(
        image: UIImage,
        output: OutputType,
        quality: CGFloat = 1) throws -> String {
        var data: Data

        switch output {
        case .PNG:
            data = image.pngData()
        default:
            data = image.jpegData(compressionQuality: quality)
        }

        guard data else {
            throw CompressionError.EncodingData
        }

        return data.base64EncodedString()
    }

    public static func resize(image: UIImage, maxWidth: Int, maxHeight: Int) -> UIImage {
        let targetSize: CGSize = findTargetSize(image, maxWidth, maxHeight)
        let targetRect: CGRect = CGRect(0, 0, targetSize.width, targetSize.height)

        UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)

        image.draw(in: targetRect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }

    public enum CompressionError: Error {
        case DecodingData
        case FileNotFound
        case EncodingData
    }

    enum OutputType: String {
        case PNG = "png"
        case JPG = "jpg"
    }

    enum InputType: String {
        case BASE64 = "base64"
        case URI = "uri"
    }

    @objc
    struct Options {
        public static func fromDict(optionsDict: [String: Any]) -> Options {
            guard optionsDict else {
                return Compressor.Options()
            }
            
            var maxWidth: Int,
                maxHeight: Int,
                quality: Float,
                output: Compressor.OutputType,
                input: Compressor.InputType
            
            for (option, value) in optionsDict {
                let stringValue = value as String
                
                switch (option) {
                case "maxWidth":
                    maxWidth = Int(stringValue)
                case "maxHeight":
                    maxHeight = Int(stringValue)
                case "quality":
                    quality = Float(stringValue)
                case "output":
                    output = OutputType(stringValue)
                case "input":
                    input = InputType(stringValue)
                }
            }
            
            return Compressor.Options(
                maxWidth: maxWidth,
                maxHeight: maxHeight,
                quality: quality,
                outputType: output,
                inputType: input)
        }
        
        let maxWidth: Int = 640
        let maxHeight: Int = 480
        let quality: Float = 1.0
        let output: OutputType = OutputType.JPG
        let input: InputType = InputType.BASE64
    }
}
