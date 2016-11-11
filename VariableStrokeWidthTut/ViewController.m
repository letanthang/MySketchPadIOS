//
//  ViewController.m
//  VariableStrokeWidthTut
//
//  Created by Le Tan Thang on 11/9/16.
//  Copyright © 2016 Le Tan Thang. All rights reserved.
//

#import "ViewController.h"
#import "FinalAlgView.h"
#import "DRColorPicker.h"
#import "PenChooseController.h"
#import "BGChooseController.h"

@interface ViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (strong, nonatomic) DRColorPickerColor* color;
@property (weak, nonatomic) DRColorPickerViewController* colorPickerVC;



@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet FinalAlgView *padView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *penButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *bgButton;

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view = [[FinalAlgView alloc] initWithFrame:self.view.bounds];
    
    //self.view.backgroundColor = [UIColor lightGrayColor];
    
    //self.padView = [[FinalAlgView alloc] initWithFrame:self.padView.bounds];
    //self.padView.backgroundColor = [UIColor whiteColor];
    //self.padView.bgColor = [UIColor whiteColor];
    //self.penButton.tintColor = [UIColor blackColor];
    
    
    
    
    
//    self.saveButton.layer.borderColor = [[UIColor blueColor] CGColor];
//    self.saveButton.layer.borderWidth = 1;
//    self.saveButton.layer.cornerRadius = 4;
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[self navigationController] setToolbarHidden:NO animated:YES];
    
    UIButton *penButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [penButton setImage:[UIImage imageNamed:@"pencil-7"] forState:UIControlStateNormal];
    [penButton addTarget:self action:@selector(penTapped:) forControlEvents:UIControlEventTouchUpInside];
    penButton.tintColor = [UIColor blueColor];
    
    penButton.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    penButton.layer.cornerRadius = 4.0;
    penButton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *penItem = [[UIBarButtonItem alloc] initWithCustomView:penButton];
    
    NSMutableArray * arr = [NSMutableArray arrayWithObjects:penItem, nil];
    
    
    UIButton *bgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bgButton setImage:[UIImage imageNamed:@"layer-7"] forState:UIControlStateNormal];
    [bgButton addTarget:self action:@selector(bgTapped:) forControlEvents:UIControlEventTouchUpInside];
    bgButton.tintColor = [UIColor blueColor];
    
    bgButton.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    bgButton.layer.cornerRadius = 4.0;
    bgButton.frame = CGRectMake(0, 0, 30, 30);
    UIBarButtonItem *bgItem = [[UIBarButtonItem alloc] initWithCustomView:bgButton];
    [arr addObject:bgItem];
    
    
    
    UIBarButtonItem *saveItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveTapped:)];
    [arr addObject:saveItem];
    
    [self setToolbarItems:arr animated:YES];
    
    
    //load config
    penButton.backgroundColor = self.penColor;
    self.padView.color = self.penColor;
    
    bgButton.backgroundColor = self.bgColor;
    self.containerView.backgroundColor = self.bgColor;

    
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}



- (IBAction)penTapped :(id)sender {
    
    [self performSegueWithIdentifier:@"showPen" sender:self];
    
}

- (IBAction)bgTapped:(id)sender {
    [self performSegueWithIdentifier:@"showBG" sender:self];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier  isEqual: @"showPen"]) {
        
        PenChooseController *vc = segue.destinationViewController;
        vc.delegate = self;
        
    } else if ([segue.identifier  isEqual: @"showBG"]) {
        
        BGChooseController *vc = segue.destinationViewController;
        vc.delegate = self;
        
    }
    
}

- (IBAction)saveTapped:(id)sender {
    
//    UIImage *image = [self.padView captureView];
    
    UIImage *image = [self captureView];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSave:didFinishSavingWithError:contextInfo:), nil);
    
    
    
}

- (void)               imageSave: (UIImage *) image
    didFinishSavingWithError: (NSError *) error
                 contextInfo: (void *) contextInfo {
    
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"Save!" message:@"Your art is saved successfully!" preferredStyle:UIAlertControllerStyleAlert];
    
    [ac addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ac dismissViewControllerAnimated:YES completion:nil];
    }]];
    
    
    [self presentViewController:ac animated:YES completion:nil];
    
}

- (UIImage *)captureView {
    
    //hide controls if needed
    CGRect rect = [self.containerView bounds];
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.containerView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
    
}
- (IBAction)widthSliderChanged:(UISlider *)sender {
    
    self.padView.lineWidth = (CGFloat) sender.value;
}



@end
