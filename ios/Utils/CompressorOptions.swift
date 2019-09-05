//
//  CompressorOptions.swift
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 05/09/2019.
//  Copyright © 2019 Facebook. All rights reserved.
//

import Foundation

class CompressorOptions {
    enum OutputType: String {
        case PNG = "png"
        case JPG = "jpg"
    }
    
    enum InputType: String {
        case BASE64 = "base64"
        case URI = "uri"
    }
    
    public static func fromDict(optionsDict: [String: Any]) -> CompressorOptions {
        let options = CompressorOptions()
        
        for (option, value) in optionsDict {
            let stringValue = value as! String
            
            switch (option) {
            case "maxWidth":
                options.maxWidth = Int(stringValue)!
            case "maxHeight":
                options.maxHeight = Int(stringValue)!
            case "quality":
                options.quality = Float(stringValue)!
            case "output":
                options.output = OutputType(rawValue: stringValue)!
            case "input":
                options.input = InputType(rawValue: stringValue)!
            default:
                continue
            }
        }
        
        return options
    }
    
    var maxWidth: Int = 640
    var maxHeight: Int = 480
    var quality: Float = 1.0
    var output: OutputType = OutputType.JPG
    var input: InputType = InputType.BASE64
}
