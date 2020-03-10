//
//  ViewController.m
//  Halftone Comparison
//
//  Created by Kirill Varshamov on 06.03.2020.
//  Copyright © 2020 Kirill Varshamov. All rights reserved.
//

#import "ViewController.h"

#import "HCHalftone.h"
#import "HCImageResize.h"
#import "HCGaussBlur.h"

@interface ViewController ()
{
    IBOutlet NSButton *buttonOutlet;
    
    
    
    NSInteger halftoneMethod;
    
    NSImage *img;
    
    HCHalftone *Halftone;
    HCImageResize *Resizer;
    HCGaussBlur *gaussianBlur;
}
@end

@implementation ViewController

@synthesize imageView;
@synthesize progressBar;

@synthesize halftoneType;

- (void)viewDidLoad {
    [super viewDidLoad];

    Halftone = [[HCHalftone alloc] init];
    Resizer  = [[HCImageResize alloc] init];
    gaussianBlur = [[HCGaussBlur alloc] init];
    progressBar.doubleValue = 0.0;
    halftoneMethod = 0;
    [self buildPopUpButton];
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
                self->img = [self->Halftone Halftone: self->img HalftoneType: self->halftoneMethod];
                self->img = [self->Resizer ResizeImage: self->img Width:500 andHeight:500];
                self->img = [self->gaussianBlur sepiaFilterImage: self->img withIntensity: 5.0];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self updateView];
//                    self->progressBar.doubleValue = 50.0;
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


-(void) buildPopUpButton
{
    [halftoneType removeAllItems];
    
    NSArray *typesLables = @[@"AM Linear", @"AM Tone increase", @"FM Linear", @"FM Tone increase"];

    [halftoneType addItemsWithTitles: typesLables];
    
    halftoneType.target = self;
    halftoneType.action = @selector(typesPopUp:);
}

- (IBAction)typesPopUp:(NSPopUpButton *)sender {
    
    halftoneMethod = sender.indexOfSelectedItem;

}


@end
