//
//  CompressionOptions.swift
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 30/08/2019.
//  Copyright © 2019 Trunkrs. All rights reserved.
//

import Foundation

enum OutputType: NSString {
    case PNG = "png"
    case JPG = "jpg"
}

enum InputType: NSString {
    case BASE64 = "base64"
    case URI = "uri"
}

@objc
struct CompressionOptions {
    var width = 480
    var height = 640
    var quality = 1.0
    var outputType = "jpg"
}
