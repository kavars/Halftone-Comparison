//
//  HCImageResize.m
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 09.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "HCImageResize.h"

@implementation HCImageResize

-(NSImage *) ResizeImage: (NSImage *) sourceImage Width: (NSInteger) width andHeight: (NSInteger) height
{
    NSImage *smallImage = [[NSImage alloc] initWithSize: NSMakeSize(width, height)];
    [smallImage lockFocus];
    [sourceImage setSize: NSMakeSize(width, height)];
    [[NSGraphicsContext currentContext] setImageInterpolation:NSImageInterpolationHigh];
    [sourceImage drawAtPoint:NSZeroPoint fromRect:CGRectMake(0, 0, width, height) operation:NSCompositingOperationCopy fraction:1.0];
    [smallImage unlockFocus];
    return smallImage;
}

@end
