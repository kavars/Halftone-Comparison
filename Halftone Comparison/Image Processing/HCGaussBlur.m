//
//  HCGaussBlur.m
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 10.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "HCGaussBlur.h"

#import <Cocoa/Cocoa.h>
//#import <MetalPerformanceShaders/MetalPerformanceShaders.h>
//#import <Metal/Metal.h>
//#import <MetalKit/MetalKit.h>

#import <CoreImage/CoreImage.h>

@implementation HCGaussBlur

//@synthesize device;
//@synthesize commandQueue;

-(instancetype) init {
    self = [super init];
    
    if (self) {
        
//        device = MTLCreateSystemDefaultDevice();
//
//        if (!MPSSupportsMTLDevice(device)) {
//            NSLog(@"Metal is not support");
//            exit(-1);
//        }
                
//        commandQueue = [device newCommandQueue];
        
        
    }
    
    return self;
}

//-(void) HCGaussianBlurWithSigma: (float) sigma andNSImage: (NSImage *) sourceImage {
//
//    id<MTLCommandBuffer> commandBuffer = [self.commandQueue commandBuffer];
//
//    MPSImageGaussianBlur *gaussianBlur = [[MPSImageGaussianBlur alloc] initWithDevice: self.device sigma: sigma];
//
//    // load img
//    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)[sourceImage TIFFRepresentation], NULL);
//    CGImageRef CGsourceImage =  CGImageSourceCreateImageAtIndex(source, 0, NULL);
//
//    NSDictionary* textureOptions = @{ MTKTextureLoaderOptionSRGB: [[NSNumber alloc] initWithBool:NO] };
//
//    id<MTLTexture> texture = [[[MTKTextureLoader alloc] initWithDevice:device] newTextureWithCGImage: CGsourceImage options: textureOptions error:nil];
//
//
//    [gaussianBlur encodeToCommandBuffer: commandBuffer sourceTexture: texture destinationTexture: texture];
//
//    [commandBuffer commit];
//
//
////    [gaussianBlur encodeToCommandBuffer: commandBuffer sourceImage:<#(nonnull MPSImage *)#> destinationImage:<#(nonnull MPSImage *)#>];
//
//
//
//
//
//}


- (NSImage*) sepiaFilterImage: (NSImage*)inputImage withIntensity:(CGFloat)intensity
{
    CIImage *inputCIImage = [[CIImage alloc] initWithData: [inputImage TIFFRepresentation]];
    
    CIFilter* sepiaFilter = [CIFilter filterWithName: @"CIGaussianBlur"];
    [sepiaFilter setValue:inputCIImage forKey:kCIInputImageKey];
    [sepiaFilter setValue:@(intensity) forKey:kCIInputRadiusKey];
        
    NSCIImageRep *rep = [NSCIImageRep imageRepWithCIImage: sepiaFilter.outputImage];
    
    inputImage = [[NSImage alloc] initWithSize:rep.size];
    [inputImage addRepresentation:rep];

    return inputImage;
}


@end
