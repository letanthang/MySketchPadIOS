//
//  FinalAlgView.h
//  VariableStrokeWidthTut
//
//  Created by Le Tan Thang on 11/9/16.
//  Copyright © 2016 Le Tan Thang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinalAlgView : UIView

@property(strong, nonatomic) UIColor *color;
@property(strong, nonatomic) UIColor *bgColor;
@property(nonatomic) CGFloat lineWidth;

- (UIImage *)captureView;
- (void) setFillBG: (UIColor *)color;
- (void)undoDraw;
- (void)redoDraw;

@end
