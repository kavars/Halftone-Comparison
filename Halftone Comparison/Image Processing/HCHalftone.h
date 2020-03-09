//
//  HCHalftone.h
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 07.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HCHalftone : NSObject

/*!
* @abstract
* Halftone computation
*
*
* @param img
* Source image
*
* @param type
* Method:
* 0 - AM Linear method
* 1 - AM Tone increase method
* 2 - FM Linear method
* 3 - FM Tone increase method
*
* @return NSImage*
*  New image
*/
-(NSImage *) Halftone: (NSImage *) img HalftoneType: (NSInteger) type;

@end

NS_ASSUME_NONNULL_END
