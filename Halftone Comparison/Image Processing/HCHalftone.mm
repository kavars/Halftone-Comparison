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

-(NSImage *) Halftone:(NSImage *)img HalftoneType:(NSInteger)type
{
    Timer timer("Halftone block");
    NSInteger newHeight;
    NSInteger newWidth;
    
    NSInteger height;
    NSInteger width;
    
    // Name for new image
    NSString *newFileName = [NSString string];

    //Get Image size
    NSImageRep *rep = [[img representations] objectAtIndex:0];
    NSSize imageSize = NSMakeSize(rep.pixelsWide, rep.pixelsHigh);
            
    newHeight = 16 * (NSInteger)imageSize.height;
    newWidth  = 16 * (NSInteger)imageSize.width;
        
    height = (NSInteger)imageSize.height;
    width  = (NSInteger)imageSize.width;
    
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

        // compute halftone and get new name
        switch (type) {
            case 0:
                newFileName = [[img name] stringByAppendingString: @"_AML.png"];
                AMHalftone([rawImg bitmapData], width, height, [greyRep bitmapData], elementsPerPixel, [greyRep bytesPerRow], [rawImg bytesPerRow], type);
                break;
            case 1:
                newFileName = [[img name] stringByAppendingString: @"_AMTI.png"];
                AMHalftone([rawImg bitmapData], width, height, [greyRep bitmapData], elementsPerPixel, [greyRep bytesPerRow], [rawImg bytesPerRow], type);
                break;
            case 2:
                newFileName = [[img name] stringByAppendingString: @"_FML.png"];
                FMHalftone([rawImg bitmapData], width, height, [greyRep bitmapData], elementsPerPixel, [greyRep bytesPerRow], [rawImg bytesPerRow], type);
                break;
            case 3:
                newFileName = [[img name] stringByAppendingString: @"_FMTI.png"];
                FMHalftone([rawImg bitmapData], width, height, [greyRep bitmapData], elementsPerPixel, [greyRep bytesPerRow], [rawImg bytesPerRow], type);
                break;
        }
                        
    }

    // Save new image
    dispatch_queue_t SaveConcurrentQueue = dispatch_queue_create("AMSave", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(SaveConcurrentQueue, ^{
        NSData *data = [greyRep representationUsingType: NSBitmapImageFileTypePNG properties: [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:1.0] forKey:NSImageCompressionFactor]];
            
        [data writeToFile: newFileName atomically: NO];
        [img setName: nil];
    });
    
    // update old image
    img = [[NSImage alloc] initWithSize: NSMakeSize(newWidth, newHeight)];
    [img addRepresentation: [greyRep copy] ];

    return img;
}

@end
