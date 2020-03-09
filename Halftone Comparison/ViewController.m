//
//  ViewController.m
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 06.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "ViewController.h"

#import "HCHalftone.h"

@interface ViewController ()
{
    IBOutlet NSButton *buttonOutlet;
    
    NSImage *img;
    
    HCHalftone *Halftone;
}
@end

@implementation ViewController

@synthesize imageView;
@synthesize progressBar;

- (void)viewDidLoad {
    [super viewDidLoad];

    Halftone = [[HCHalftone alloc] init];
    progressBar.doubleValue = 0.0;
//    img = [[NSImage alloc] init];
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}



- (IBAction)TAP:(NSButton *)sender {

    NSOpenPanel *panel = [[NSOpenPanel alloc] init];
    
    panel.title = @"Open palette file";
    
    panel.showsResizeIndicator    = true;
    panel.showsHiddenFiles        = false;
    panel.canChooseDirectories    = true;
    panel.canCreateDirectories    = true;
    panel.allowsMultipleSelection = false;
    panel.allowedFileTypes        = @[@"png", @"tiff", @"tif"];
    
    if ([panel runModal] == NSModalResponseOK) {
        // Pathname of the file
        NSURL *result = panel.URL;
        
        if (result != nil) {
            [self openImg: result];
            
            dispatch_queue_t AMLConcurrentQueue = dispatch_queue_create("AMLinear", DISPATCH_QUEUE_CONCURRENT);
            
            dispatch_async(AMLConcurrentQueue, ^{
                self->img = [self->Halftone AM: self->img AMType: 0];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateView];
//                    self->progressBar.doubleValue = 100.0;
                });
            });
            

        }
    } else {
        // User clicked on "Cancel"
        return;
    }

}


- (void) openImg: (NSURL *) path {
    img = [[NSImage alloc] initWithContentsOfFile: path.path];
    
    [img setName: [[path URLByDeletingPathExtension] lastPathComponent]];
}

- (void) updateView {
    imageView.image = img;
}





@end
