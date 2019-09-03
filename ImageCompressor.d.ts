export enum InputType {
  base64 = "base64",
  uri = "uri",
}

export enum OutputType {
  jpeg = "jpeg",
  png = "png",
}

export interface CompressorOptions {
  /***
   * The maximum width boundary used when compressing a landscape image.
   */
  maxWidth: number
  /***
   * The maximum height boundary used when compressing a portrait image.
   */
  maxHeight: number
  /***
   * The compression factor used when compressing JPEG images. Won't be used in PNG.
   */
  quality: number
  /***
   * The type of data the input value contains.
   */
  input: InputType
  /***
   * The output image type.
   */
  output: OutputType
}

export class ImageCompressor {
  /***
   * Resizes the image to the maximum boundary and compress into specified type
   * and quality.
   * @param {string} value The BASE64 string or file URI for input image.
   * @param {CompressorOptions} options The options for the compressor to use.
   * @returns {Promise<string>} BASE64 string representation of the compressed image.
   */
  public static compress(value: string, options?: CompressorOptions): Promise<string>
}
