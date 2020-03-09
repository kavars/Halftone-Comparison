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

-(NSImage *) AM: (NSImage *) img AMType: (NSInteger) type;

@end

NS_ASSUME_NONNULL_END
