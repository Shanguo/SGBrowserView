//
//  UIView+SG.m
//  Toing
//
//  Created by Rdd7 on 7/5/15.
//  Copyright (c) 2015 bibibi. All rights reserved.
//

#import "UIView+SG.h"

@implementation UIView(SG)

-(void)setCircleRadius:(CGFloat)radius{
    self.layer.cornerRadius = radius;
    [self.layer setMasksToBounds:YES];
}

- (void)setBorderWidth:(CGFloat)width Color:(UIColor*)color{
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
}

- (CGFloat)mwidth {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)mheight {
    return CGRectGetHeight(self.frame);
}

- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}
- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}
- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}
- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}
- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}



@end
