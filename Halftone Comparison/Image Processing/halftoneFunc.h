#include <iostream>
#include <vector>
#include <array>

#include "Timer.hpp"


void AMLinear(unsigned char* image, unsigned& width , unsigned& height, unsigned char* newImg, size_t bitsPerPixel, size_t rowBytes, size_t rowBytesOld);

void hFML(std::vector<int>& image, unsigned& width, unsigned& height, std::vector<int>& newImg);

void hAMTI(std::vector<int>& image, unsigned& width , unsigned& height, std::vector<int>& newImg);
void hFMTI(std::vector<int>& image, unsigned& width, unsigned& height, std::vector<int>& newImg);
