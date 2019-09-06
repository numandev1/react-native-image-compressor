//
//  TRNCompressor.m
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 30/08/2019.
//  Copyright © 2019 Trunkrs. All rights reserved.
//

#import "Utils/Compressor.h"
#import "Utils/CompressorOptions.h"

#import "TRNCompressor.h"

@implementation TRNCompressor

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(
    compress: (NSString*) value
    optionsDict: (NSDictionary*) optionsDict
    resolver: (RCTPromiseResolveBlock) resolve
    rejecter: (RCTPromiseRejectBlock) reject) {
    @try {
        CompressorOptions *options = [CompressorOptions fromDictionary:optionsDict];
        
        UIImage *image;
        switch (options.input) {
            case base64:
                image = [Compressor decodeImage: value];
                break;
            case uri:
                image = [Compressor loadImage: value];
                break;
            default:
                reject(@"unsupported_value", @"Unsupported value type.", nil);
                return;
        }
        
        UIImage *resizedImage = [Compressor resize:image maxWidth:options.maxWidth maxHeight:options.maxHeight];
        NSString *result = [Compressor compress:resizedImage output:options.output quality:options.quality];
        
        resolve(result);
    }
    @catch (NSException *exception) {
        reject(exception.name, exception.reason, nil);
    }
}

@end
