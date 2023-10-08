# 🚧 🚧 🚧
## react-native-image-compressor is deprecated.

react-native-image-compressor is now deprecated in favor of [react-native-compressor](https://github.com/numandev1/react-native-compressor).

# react-native-image-compressor

A simple image resizing and compression package, taking care of the resizing process on the native side. Supports iOS and Android out of the box.

## Getting started

`$ npm install @nomi9995/react-native-image-compressor --save`

`$ yarn add @nomi9995/react-native-image-compressor`

### Mostly automatic installation

`$ react-native link @nomi9995/react-native-image-compressor`

### Manual installation

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-image-compressor` and add `TRNReactNativeImageCompressor.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libTRNReactNativeImageCompressor.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`

- Add `import com.nomi9995.imagecompressor.TRNReactNativeImageCompressorPackage;` to the imports at the top of the file
- Add `new TRNReactNativeImageCompressorPackage()` to the list returned by the `getPackages()` method

2. Append the following lines to `android/settings.gradle`:
   ```
   include ':@nomi9995_react-native-image-compressor'
   project(':@nomi9995_react-native-image-compressor').projectDir = new File(rootProject.projectDir, 	'../node_modules/@nomi9995/react-native-image-compressor/android')
   ```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
   ```
     implementation project(':@nomi9995_react-native-image-compressor')
   ```

## Usage

```javascript
import ImageCompressor from "@nomi9995/react-native-image-compressor";

const result = await ImageCompressor.compress(
  "file://bowling-alleys/the-dude.jpg",
  {
    maxWidth: 1000,
  }
);
```

# API

### ImageCompressor

- ###### `compress(value: string, options?: CompressorOptions): Promise<string>`

  Compresses the input file URI or base-64 string with the specified options. Promise returns a string after compression has completed. Resizing will always keep the original aspect ratio of the image, the `maxWidth` and `maxHeight` are used as a boundary.

### CompressorOptions

- ###### `maxWidth: number` (default: 1024)

  The maximum width boundary used as the main boundary in resizing a landscape image.

- ###### `maxHeight: number` (default: 1024)

  The maximum height boundary used as the main boundary in resizing a portrait image.

- ###### `quality: number` (default: 1.0)

  The quality modifier for the `JPEG` file format, can be specified when output is `PNG` but will be ignored.

- ###### `input: InputType` (default: uri)

  Can be either `uri` or `base64`, defines the contentents of the `value` parameter.

- ###### `output: OutputType` (default: jpg)

  Can be either `jpg` or `png`, defines the output image format.

- ###### `returnableOutputType: ReturnableOutputType` (default: uri)
  Can be either `uri` or `base64`, defines the Returnable output image format.
