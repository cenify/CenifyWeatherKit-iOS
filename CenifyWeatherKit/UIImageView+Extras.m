//
//  UIImageView+Extras.m
//  CenifyUtilities
//
//  Created by Gregory Sapienza on 2/6/16.
//  Copyright © 2016 Cenify. All rights reserved.
//

#import "UIImageView+Extras.h"

@implementation UIImageView (Extras)

- (void)tintImage:(UIColor *)color {
    self.image = [self.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [self setTintColor:color];
}

@end
