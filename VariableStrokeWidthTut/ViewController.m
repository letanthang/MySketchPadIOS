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



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //0: init config
    self.penColor = [UIColor blackColor];
    self.bgColor = [UIColor whiteColor];
    self.penWidth = 1.0;
    self.penEffect = 0.03;
    
    //1: style navigation bar title
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor blueColor], NSFontAttributeName: [UIFont fontWithName:@"Baskerville-Italic" size:22]}];
    
    
    //2: create flash text for sketch pad
    UILabel *flashLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 44)];
    
    //flashLabel.text = @"Lets Draw!";
    [flashLabel setCenter:self.view.center];
    
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"Let's Draw With Us!"];
    [attributedString addAttributes:@{NSForegroundColorAttributeName :[UIColor redColor], NSFontAttributeName: [UIFont fontWithName:@"Baskerville-Italic" size:24]} range:NSMakeRange(0,5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(5,5)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(10,5)];
    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor], NSFontAttributeName: [UIFont fontWithName:@"Baskerville-Italic" size:23]} range:NSMakeRange(15,4)];
    
   
    
    [flashLabel setAttributedText:attributedString];
    
    flashLabel.alpha = 0.5;
    
    [self.view addSubview:flashLabel];
    
    
    //3: display & hide it with animator
   
    
    UIViewPropertyAnimator *animator = [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.9 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        flashLabel.alpha = 1.0;
        flashLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.4, 1.4);
        
    } completion:^(UIViewAnimatingPosition finalPosition) {
        UIViewPropertyAnimator *animator1 = [UIViewPropertyAnimator runningPropertyAnimatorWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            flashLabel.alpha = 0;
            flashLabel.transform = CGAffineTransformIdentity;
            
        } completion:^(UIViewAnimatingPosition finalPosition) {
            [flashLabel removeFromSuperview];
        }];

        [animator1 startAnimation];
    }];
    
    
    [animator startAnimation];
    
    
}

-(BOOL)prefersStatusBarHidden {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.containerView.backgroundColor = self.bgColor;
    self.padView.color = self.penColor;
    self.padView.lineWidth = self.penWidth;
    self.padView.lineEffect = self.penEffect;
    
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
