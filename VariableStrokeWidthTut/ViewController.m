//
//  ViewController.m
//  VariableStrokeWidthTut
//
//  Created by Le Tan Thang on 11/9/16.
//  Copyright © 2016 Le Tan Thang. All rights reserved.
//

#import "ViewController.h"
#import "FinalAlgView.h"
#import "ConfigViewController.h"


@interface ViewController ()


@property (strong, nonatomic) IBOutlet UIView *containerView;

@property (strong, nonatomic) IBOutlet FinalAlgView *padView;

@property (strong, nonatomic) IBOutlet UIButton *colorButton;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property (strong, nonatomic) IBOutlet UISlider *widthSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view = [[FinalAlgView alloc] initWithFrame:self.view.bounds];
    
//    self.view.backgroundColor = [UIColor lightGrayColor];
    
//    self.padView = [[FinalAlgView alloc] initWithFrame:self.padView.bounds];
    //self.padView.backgroundColor = [UIColor whiteColor];

    self.penColor = [UIColor blackColor];
    self.bgColor = [UIColor whiteColor];
    self.penWidth = 1.0;
    
    
    

    self.saveButton.layer.borderColor = [[UIColor blueColor] CGColor];
    self.saveButton.layer.borderWidth = 1;
    self.saveButton.layer.cornerRadius = 4;
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.containerView.backgroundColor = self.bgColor;
    self.padView.color = self.penColor;
    self.padView.lineWidth = self.penWidth;
    
    if (self.bgImage) {
        self.containerView.backgroundColor = [UIColor colorWithPatternImage:self.bgImage];
    }
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveTapped:(id)sender {
    
//    UIImage *image = [self.padView captureView];
    
    UIImage *image = [self captureView];
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSave:didFinishSavingWithError:contextInfo:), nil);
    
    
    
}

- (IBAction)undoTapped:(id)sender {
    [self.padView undoDraw];
}

- (IBAction)redoTapped:(id)sender {
    [self.padView redoDraw];
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqual:@"showConfig"]) {
        
        ConfigViewController *vc = segue.destinationViewController;
        vc.delegate = self;
        
    }
}



@end
