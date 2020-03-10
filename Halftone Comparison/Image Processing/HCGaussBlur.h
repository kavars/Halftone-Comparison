//
//  HCGaussBlur.h
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 10.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <Metal/Metal.h>
//#import <MetalPerformanceShaders/MetalPerformanceShaders.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCGaussBlur : NSObject

//@property id <MTLDevice> device;
//@property id <MTLCommandQueue> commandQueue;

-(instancetype) init;

- (NSImage*) sepiaFilterImage: (NSImage*)inputImage withIntensity:(CGFloat)intensity;

@end

NS_ASSUME_NONNULL_END
