//
//  halftoneFunc.cpp
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 09.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#include "halftoneFunc.h"

#include "Timer.hpp"

#pragma mark - AM

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
void AMHalftone(unsigned char* image, size_t width , size_t height, unsigned char* newImg, size_t bitsPerPixel, size_t rowBytesDest, size_t rowBytesSrc, size_t AMType) {

    Timer timer("AM");

    int halftoneArray16x16AM[16][16] = {
        {  0,   4,  12,  24,  40,  60,  84, 112, 113,  85,  61,  41,  25,  13,   5,   1},
        {  8,  20,  32,  48,  68,  92, 120, 144, 145, 121,  93,  69,  49,  33,  21,   9},
        { 16,  36,  56,  76, 100, 128, 152, 172, 173, 153, 129, 101,  77,  57,  37,  17},
        { 28,  52,  80, 104, 132, 160, 180, 196, 197, 181, 161, 133, 105,  81,  53,  29},
        { 44,  72, 108, 136, 164, 188, 204, 216, 217, 205, 189, 165, 137, 109,  73,  45},
        { 64,  96, 140, 168, 192, 212, 224, 232, 233, 225, 213, 193, 169, 141,  97,  65},
        { 88, 124, 156, 184, 208, 228, 240, 244, 245, 241, 229, 209, 185, 157, 125,  89},
        {116, 148, 176, 200, 220, 236, 248, 252, 253, 249, 237, 221, 201, 177, 149, 117},
        {119, 151, 179, 203, 223, 239, 251, 255, 254, 250, 238, 222, 202, 178, 150, 118},
        { 91, 127, 159, 187, 211, 231, 243, 247, 246, 242, 230, 210, 186, 158, 126,  90},
        { 67,  99, 143, 171, 195, 215, 227, 235, 234, 226, 214, 194, 170, 142,  98,  66},
        { 47,  75, 111, 139, 167, 191, 207, 219, 218, 206, 190, 166, 138, 110,  74,  46},
        { 31,  55,  83, 107, 135, 163, 183, 199, 198, 182, 162, 134, 106,  82,  54,  30},
        { 19,  39,  59,  79, 103, 131, 155, 175, 174, 154, 130, 102,  78,  58,  38,  18},
        { 11,  23,  35,  51,  71,  95, 123, 147, 146, 122,  94,  70,  50,  34,  22,  10},
        {  3,   7,  15,  27,  43,  63,  87, 115, 114,  86,  62,  42,  26,  14,   6,   2}
    };
    
    for (size_t i = 0, iNew = 0; i < height; ++i, iNew+=16 )
    {
        for (size_t j = 0, jNew = 0; j < width * bitsPerPixel; j+=bitsPerPixel, jNew+=16 )
        {
            int pixel = static_cast<int>(image[i * rowBytesSrc + j]);
            
//            iso 12647-2
            // Tone increase method
            if (AMType == 1) {
                if (pixel < 13) { // 5%
                    pixel -= pixel * 0.046;
                } else if (pixel < 26) { // 10%
                    pixel -= pixel * 0.083;
                } else if (pixel < 51) { // 20%
                    pixel -= pixel * 0.139;
                } else if (pixel < 77) { // 30%
                    pixel -= pixel * 0.172;
                } else if (pixel < 102) { // 40%
                    pixel -= pixel * 0.188;
                } else if (pixel < 128) { // 50%
                    pixel -= pixel * 0.19;
                } else if (pixel < 153) { // 60%
                    pixel -= pixel * 0.179;
                } else if (pixel < 179) { // 70%
                    pixel -= pixel * 0.157;
                } else if (pixel < 204) { // 80%
                    pixel -= pixel * 0.121;
                } else if (pixel < 230) { // 90%
                    pixel -= pixel * 0.07;
                } else if (pixel < 243) { // 95%
                    pixel -= pixel * 0.038;
                }
            }
            
            
            for (size_t ii = 0; ii != 16; ii++)
            {
                for (size_t jj = 0; jj != 16; jj++)
                {
                    if (pixel == 255 || halftoneArray16x16AM[ii][jj] < (pixel)) {
                        newImg[(iNew + ii) * rowBytesDest + (jNew + jj)] = static_cast<unsigned char>(255);
                    } else {
                        newImg[(iNew + ii) * rowBytesDest + (jNew + jj)] = static_cast<unsigned char>(0);
                    }
                }
            }
        }
    }
}

#pragma mark - FM

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
* 0 - Linear method
* 1 - Tone increase method
*/
void FMHalftone(unsigned char* image, size_t width , size_t height, unsigned char* newImg, size_t bitsPerPixel, size_t rowBytesDest, size_t rowBytesSrc, size_t FMType) {

    Timer timer("FM");

    const size_t arrCnt = 100;

    int halftoneArray16x16FM[arrCnt][16][16];

    // fill part
    srand(static_cast<unsigned int>(time(0)));

    for (size_t mn = 0; mn < arrCnt; mn++)
    {
        for (size_t i = 0; i != 16; i++)
        {
            for (size_t j = 0; j != 16; j++)
            {
                    while (true)
                    {
                        int randomNumber = (rand() % 257) + 1;

                        bool checkFlag = true;
                        for (size_t c = 0; c != 16; c++)
                        {
                            for (size_t v = 0; v != 16; v++)
                            {
                                if (halftoneArray16x16FM[mn][c][v] == randomNumber) {
                                    checkFlag = false;
                                }
                            }
                        }

                        if (checkFlag)
                        {
                            if (randomNumber > 255) {
                                randomNumber = 1;
                            }
                            halftoneArray16x16FM[mn][i][j] = randomNumber;
                            break;
                        }

                    }
            }
        }
    }
    
    for (size_t i = 0, iNew = 0; i < height; ++i, iNew+=16 )
    {
        for (size_t j = 0, jNew = 0; j < width * bitsPerPixel; j+=bitsPerPixel, jNew+=16 )
        {
            int pixel = static_cast<int>(image[i * rowBytesSrc + j]);
            
//            iso 12647-2
            // Tone increase method
            if (FMType == 1) {
                if (pixel < 13) { // 5%
                    pixel -= pixel * 0.068;
                } else if (pixel < 26) { // 10%
                    pixel -= pixel * 0.126;
                } else if (pixel < 51) { // 20%
                    pixel -= pixel * 0.212;
                } else if (pixel < 77) { // 30%
                    pixel -= pixel * 0.264;
                } else if (pixel < 102) { // 40%
                    pixel -= pixel * 0.285;
                } else if (pixel < 128) { // 50%
                    pixel -= pixel * 0.28;
                } else if (pixel < 153) { // 60%
                    pixel -= pixel * 0.253;
                } else if (pixel < 179) { // 70%
                    pixel -= pixel * 0.207;
                } else if (pixel < 204) { // 80%
                    pixel -= pixel * 0.147;
                } else if (pixel < 230) { // 90%
                    pixel -= pixel * 0.077;
                } else if (pixel < 243) { // 95%
                    pixel -= pixel * 0.039;
                }
            }
            
            // get random FM matrix
            int randomMatrix = (rand() % arrCnt);
            
            for (size_t ii = 0; ii != 16; ii++)
            {
                for (size_t jj = 0; jj != 16; jj++)
                {
                    if (pixel == 255 || halftoneArray16x16FM[randomMatrix][ii][jj] < (pixel)) {
                        newImg[(iNew + ii) * rowBytesDest + (jNew + jj)] = static_cast<unsigned char>(255);
                    } else {
                        newImg[(iNew + ii) * rowBytesDest + (jNew + jj)] = static_cast<unsigned char>(0);
                    }
                }
            }
        }
    }
}
