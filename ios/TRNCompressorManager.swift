//
//  Compressor.swift
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 30/08/2019.
//  Copyright © 2019 Trunkrs. All rights reserved.
//

import Foundation
import UIKit

@objc(TRNCompressorManager)
class TRNCompressorManager: NSObject {
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return false
    }
    
    @objc
    func compressBase64(
        _ value: NSString,
        options optionsDict: [NSString: Any],
        resolver resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
        ) -> Void {
        
        let options: Compressor.Options = Compressor.Options.fromDict(optionsDict)
        
        do {
            let image: UIImage = options.input == Compressor.InputType.BASE64
                ? try Compressor.decodeImage(value)
                : try Compressor.loadImage(value)
            
            let resized: UIImage = try Compressor.resize(image, options.maxWidth, options.maxHeight)
            let encoded: String = try Compressor.compress(resized, options.output, options.quality)
            
            resolve(encoded)
        } catch Compressor.CompressionError.DecodingData {
            reject("decoding_data", "Error decoding base64 string.")
        } catch Compressor.CompressionError.FileNotFound {
            reject("file_not_found", "Error reading the file from the specified path URI.")
        } catch Compressor.CompressionError.EncodingData {
            reject("encoding_data", "Something went wrong while re-encoding the compressed image.")
        }
    }
}
