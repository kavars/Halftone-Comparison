//
//  halftoneFunc.h
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 09.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#include <iostream>
#include <vector>

void AMHalftone(unsigned char* image, size_t width , size_t height, unsigned char* newImg, size_t bitsPerPixel, size_t rowBytesDest, size_t rowBytesSrc, size_t AMType);
void FMHalftone(unsigned char* image, size_t width , size_t height, unsigned char* newImg, size_t bitsPerPixel, size_t rowBytesDest, size_t rowBytesSrc, size_t FMType);
