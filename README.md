# react-native-image-compressor

## Getting started

`$ npm install @trunkrs/react-native-image-compressor --save`

### Mostly automatic installation

`$ react-native link @trunkrs/react-native-image-compressor`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-image-compressor` and add `TRNReactNativeImageCompressor.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libTRNReactNativeImageCompressor.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainApplication.java`
  - Add `import com.trunkrs.imagecompressor.TRNReactNativeImageCompressorPackage;` to the imports at the top of the file
  - Add `new TRNReactNativeImageCompressorPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-image-compressor'
  	project(':react-native-image-compressor').projectDir = new File(rootProject.projectDir, 	'../node_modules/@trunkrs/react-native-image-compressor/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      implementation project(':react-native-image-compressor')
  	```


## Usage
```javascript
import TRNReactNativeImageCompressor from 'react-native-image-compressor';

// TODO: What to do with the module?
TRNReactNativeImageCompressor;
```
