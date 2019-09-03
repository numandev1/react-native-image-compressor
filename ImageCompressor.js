const { NativeModules } = require('react-native')
const { TRNCompressor } = NativeModules

const base64UrlRegex = /^data:image\/.*;(?:charset=.{3,5};)?base64,/

export default class ImageCompressor {
  static compress = async (value, options) => {
    if (!value) {
      throw new Error('Compression value is empty, please provide a value for compression.')
    }

    const cleanData = value.replace(base64UrlRegex, '')
    return await TRNCompressor.compress(cleanData, options)
  }
}

