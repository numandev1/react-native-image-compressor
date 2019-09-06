//
//  Compressor.h
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 05/09/2019.
//  Copyright © 2019 Trunkrs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CompressorOptions.h"

@interface Compressor: NSObject
+ (UIImage*)decodeImage: (NSString*) base64;
+ (UIImage*)loadImage: (NSString*) path;

+ (UIImage*) resize: (UIImage*) image maxWidth: (int) maxWidth maxHeight: (int) maxHeight;
+ (NSString*) compress: (UIImage*) image output: (enum OutputType) output quality: (float) quality;
@end
