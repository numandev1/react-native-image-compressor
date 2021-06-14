//
//  TRNCompressor.m
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 30/08/2019.
//  Copyright © 2019 nomi9995. All rights reserved.
//

#import "Utils/ImageCompressor.h"
#import "Utils/imageCompressorOptions.h"

#import "TRNCompressor.h"

@implementation TRNCompressor

RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(
    compress: (NSString*) value
    optionsDict: (NSDictionary*) optionsDict
    resolver: (RCTPromiseResolveBlock) resolve
    rejecter: (RCTPromiseRejectBlock) reject) {
    @try {
           ImageCompressorOptions *options = [ImageCompressorOptions fromDictionary:optionsDict];

           UIImage *image;
           switch (options.input) {
               case base64:
                   image = [ImageCompressor decodeImage: value];
                   break;
               case uri:
                   image = [ImageCompressor loadImage: value];
                   break;
               default:
                   reject(@"unsupported_value", @"Unsupported value type.", nil);
                   return;
           }
           NSString *outputExtension=[ImageCompressorOptions getOutputInString:options.output];
           UIImage *resizedImage = [ImageCompressor resize:image maxWidth:options.maxWidth maxHeight:options.maxHeight];
           Boolean isBase64=options.returnableOutputType ==rbase64;
           NSString *result = [ImageCompressor compress:resizedImage output:options.output quality:options.quality outputExtension:outputExtension isBase64:isBase64];
           resolve(result);
       }
       @catch (NSException *exception) {
           reject(exception.name, exception.reason, nil);
       }
}

@end
