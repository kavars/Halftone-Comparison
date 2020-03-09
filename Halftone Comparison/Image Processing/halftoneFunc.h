//
//  halftoneFunc.h
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 09.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#include <iostream>
#include <vector>

/*!
* @function AMHalftone
*
* @abstract
* Amplitude modulation Halftone
*
*
* @param image
* Source raw image data
*
* @param width
* Source image width
 
* @param height
* Source image height
*
* @param newImg
* Destination raw image data
*
* @param bitsPerPixel
* Bits per pixel in source image
*
* @param rowBytesDest
* Row bytes in destination image
*
* @param rowBytesSrc
* Row bytes in source image
*
* @param AMType
* Amplitude modulation method
* 0 - Linear method
* 1 - Tone increase method
*/
void AMHalftone(unsigned char* image, size_t width , size_t height, unsigned char* newImg, size_t bitsPerPixel, size_t rowBytesDest, size_t rowBytesSrc, size_t AMType);

/*!
* @function FMHalftone
*
* @abstract
* Frequency modulation Halftone
*
* @param image
* Source raw image data
*
* @param width
* Source image width
 
* @param height
* Source image height
*
* @param newImg
* Destination raw image data
*
* @param bitsPerPixel
* Bits per pixel in source image
*
* @param rowBytesDest
* Row bytes in destination image
*
* @param rowBytesSrc
* Row bytes in source image
*
* @param FMType
* Frequency modulation method
* 2 - Linear method
* 3 - Tone increase method
*/
void FMHalftone(unsigned char* image, size_t width , size_t height, unsigned char* newImg, size_t bitsPerPixel, size_t rowBytesDest, size_t rowBytesSrc, size_t FMType);
