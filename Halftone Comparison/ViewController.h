//
//  ViewController.h
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 06.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface ViewController : NSViewController

- (IBAction)TAP:(NSButton *)sender;

@property (weak) IBOutlet NSImageView *imageView;
@property (weak) IBOutlet NSProgressIndicator *progressBar;

@end

