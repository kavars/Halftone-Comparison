//
//  HCHalftone.mm
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 07.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "HCHalftone.h"

#import "Timer.hpp"

#import <vector>

#import "halftoneFunc.h"

@implementation HCHalftone

-(NSImage *) AML: (NSImage *) img
{
    Timer timer("AML Full block");
    NSInteger newHeight;
    NSInteger newWidth;
    
    unsigned int Height;
    unsigned int Width;
    
    // Get name for new image
    NSString *newFileName = [[img name] stringByAppendingString: @"_AML.png"];

    //Get Image size
    @autoreleasepool {
        NSImageRep *rep = [[img representations] objectAtIndex:0];
        NSSize imageSize = NSMakeSize(rep.pixelsWide, rep.pixelsHigh);
            
        newHeight = 16 * (NSInteger)imageSize.height;
        newWidth  = 16 * (NSInteger)imageSize.width;
        
        Height = (unsigned int)imageSize.height;
        Width  = (unsigned int)imageSize.width;
    }
    
    // Create new image bitmap
    NSBitmapImageRep *greyRep =
    [[NSBitmapImageRep alloc]
        initWithBitmapDataPlanes: nil  // allocate the pixel buffer for us
                      pixelsWide: newWidth
                      pixelsHigh: newHeight
                   bitsPerSample: 8
                 samplesPerPixel: 1
                        hasAlpha: NO
                        isPlanar: NO
                  colorSpaceName: NSCalibratedWhiteColorSpace // 0 = black, 1 = white in this color space
                     bytesPerRow: newWidth     // passing 0 means "you figure it out"
                    bitsPerPixel: 8];
    
    @autoreleasepool {
        NSBitmapImageRep *rawImg = [NSBitmapImageRep imageRepWithData: [img TIFFRepresentation]];
                        
        // get color type: RGB, RGBA, Gray, GrayA
        NSInteger bitsPerPixel = [rawImg bitsPerPixel];
        NSInteger elementsPerPixel = 0;
        
        switch (bitsPerPixel) {
            case 32:
                elementsPerPixel += 4;
                break;
            case 24:
                elementsPerPixel += 3;
                break;
            case 16:
                elementsPerPixel += 2;
                break;
            case 8:
                elementsPerPixel += 1;
                break;
            default:
                break;
        }
                        
        // compute halftone
        AMLinear([rawImg bitmapData], Width, Height, [greyRep bitmapData], elementsPerPixel, [greyRep bytesPerRow], [rawImg bytesPerRow]);
        

                
    }
    
    // Save new image
    dispatch_queue_t SaveConcurrentQueue = dispatch_queue_create("AMSave", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(SaveConcurrentQueue, ^{
        NSData *data = [greyRep representationUsingType: NSBitmapImageFileTypePNG properties: [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor]];
            
        [data writeToFile: newFileName atomically: NO];
    });
    
    // update old image
    img = [[NSImage alloc] initWithSize: NSMakeSize(newWidth, newHeight)];
    [img addRepresentation: [greyRep copy] ];

    
    // Resize
    NSImage *sourceImage = img;

    // Report an error if the source isn't a valid image
    if (![sourceImage isValid]){
        NSLog(@"Invalid Image");
    } else {
        NSImage *smallImage = [[NSImage alloc] initWithSize: NSMakeSize(Width, Height)];
        [smallImage lockFocus];
        [sourceImage setSize: NSMakeSize(Width, Height)];
        [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
        [sourceImage drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, NSMakeSize(Width, Height).width, NSMakeSize(Width, Height).height) operation:NSCompositingOperationCopy fraction:1.0];
        [smallImage unlockFocus];
        img = smallImage;
    }
    

    
    return img;
}

@end
