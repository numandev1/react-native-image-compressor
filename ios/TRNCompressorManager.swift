//
//  Compressor.swift
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 30/08/2019.
//  Copyright © 2019 Trunkrs. All rights reserved.
//

import UIKit

@objc(TRNCompressorManager)
class TRNCompressorManager: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    @objc
    func compress(
        _ value: NSString,
        options optionsDict: NSDictionary,
        resolver resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
        ) -> Void {
        let options = CompressorOptions.fromDict(optionsDict: optionsDict as! [String: Any])
        
        do {
            let image: UIImage = options.input == CompressorOptions.InputType.BASE64
                ? try Compressor.decodeImage(base64String: value as String)
                : try Compressor.loadImage(path: value as String)
            
            let resized: UIImage = try Compressor.resize(image: image, maxWidth: options.maxWidth, maxHeight: options.maxHeight)
            let encoded: String = try Compressor.compress(image: resized, output: options.output, quality: options.quality)
            
            resolve(encoded)
        } catch Compressor.CompressionError.DecodingData {
            reject("decoding_data", "Error decoding base64 string.", nil)
        } catch Compressor.CompressionError.FileNotFound {
            reject("file_not_found", "Error reading the file from the specified path URI.", nil)
        } catch Compressor.CompressionError.EncodingData {
            reject("encoding_data", "Something went wrong while re-encoding the compressed image.", nil)
        } catch Compressor.CompressionError.Drawing {
            reject("drawing_error", "Something went wrong while re-sizing the image.", nil)
        } catch {
            reject("general_error", "Something went wrong while converting your image.", nil)
        }
    }
}
