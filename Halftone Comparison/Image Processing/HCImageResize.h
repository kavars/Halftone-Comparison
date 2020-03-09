//
//  HCImageResize.h
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 09.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCImageResize : NSObject

-(NSImage *) ResizeImage: (NSImage *) sourceImage Width: (NSInteger) width andHeight: (NSInteger) height;

@end

NS_ASSUME_NONNULL_END
