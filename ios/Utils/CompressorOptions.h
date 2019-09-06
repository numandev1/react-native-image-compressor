//
//  CompressorOptions.h
//  TRNReactNativeImageCompressor
//
//  Created by Leonard Breitkopf on 05/09/2019.
//  Copyright © 2019 Trunkrs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(long, OutputType) {
    jpg, png
};

typedef NS_ENUM(long, InputType) {
    base64, uri
};

@interface CompressorOptions : NSObject
+ (CompressorOptions*) fromDictionary: (NSDictionary*) dictionary;

@property (nonatomic, assign) int maxWidth;
@property (nonatomic, assign) int maxHeight;
@property (nonatomic, assign) float quality;
@property (nonatomic, assign) enum OutputType output;
@property (nonatomic, assign) enum InputType input;

@end
