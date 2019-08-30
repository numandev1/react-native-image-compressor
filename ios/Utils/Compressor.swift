//
//  Compressor.swift
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 30/08/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation
import UIKit

import WXImageCompress

class Compressor {
    static func decodeImage(base64String: String) -> UIImage {
        let rawData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters)!
        
        return UIImage(data: rawData)
    }

    static func loadImage(path: String) -> UIImage {
        let rawData = Data()
    }
    
    static func encodeImage(image: UIImage) -> String {
        
    }
}
