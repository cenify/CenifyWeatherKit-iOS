//
//  CENRainyDayBackgroundView.m
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/19/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import "CENRainyDayBackgroundView.h"

@interface CENRainyDayBackgroundView()

@property (nonatomic) NSArray *_rainDropViews;

@end

@implementation CENRainyDayBackgroundView
@synthesize _rainDropViews = __rainDropViews;

int rainDropHeight = 20;

- (NSArray *)_rainDropViews {
    if ( !__rainDropViews ) {
        __rainDropViews = [[NSArray alloc] init];
        for ( int i = 0; i < self.bounds.size.width; i++ ) {
            CENRainDropView *rainDrop = [[CENRainDropView alloc] initWithFrame:CGRectMake(i + 1, -rainDropHeight, 2, rainDropHeight)];
            rainDrop.image = [UIImage imageNamed:@"RainDrop" inBundle:[NSBundle bundleForClass:[CENRainyDayBackgroundView class]] compatibleWithTraitCollection:nil];
            rainDrop.alpha = 0.3;
            rainDrop.layer.drawsAsynchronously = YES;
            rainDrop.layer.opaque = YES;
            rainDrop.layer.shouldRasterize = YES;
            rainDrop.layer.allowsGroupOpacity = NO;
            
            __rainDropViews = [__rainDropViews arrayByAddingObject:rainDrop];
        }
    }
    
    return __rainDropViews;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setUpBackgroundImage];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(setUpRainDropAnimations) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setUpBackgroundImage {
    UIImage *backgroundImage = [UIImage imageNamed:@"RainyDayBackground" inBundle:[NSBundle bundleForClass:[CENRainyDayBackgroundView class]] compatibleWithTraitCollection:nil];
    
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    backgroundImageView.image = backgroundImage;
    [self addSubview:backgroundImageView];
}

- (void)setUpRainDropAnimations {
    __weak typeof(self) weakself = self;
    
    CENRainDropView *currentRainDrop1 = [weakself getRandomRainDrop];
    
    CENRainDropView *currentRainDrop2 = [weakself getRandomRainDrop];
    
    CENRainDropView *currentRainDrop3 = [weakself getRandomRainDrop];
    
    [weakself addSubview:currentRainDrop1];
    [weakself addSubview:currentRainDrop2];
    [weakself addSubview:currentRainDrop3];

    CENRainDropView *currentRainDrop4;
    
    int largeDropRandomValue = arc4random_uniform(20);
    if ( largeDropRandomValue == 10 ) {
        currentRainDrop4 = [weakself getRandomRainDrop];
        currentRainDrop4.frame = CGRectMake(currentRainDrop4.frame.origin.x, currentRainDrop4.frame.origin.y, 5, 50);
        [weakself addSubview:currentRainDrop4];

        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            currentRainDrop4.frame = CGRectMake(currentRainDrop4.frame.origin.x, weakself.bounds.size.height, currentRainDrop4.frame.size.width, currentRainDrop4.frame.size.height);
        } completion:^(BOOL finished) {
            [currentRainDrop4 removeFromSuperview];
        }];
    }
    
    [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        currentRainDrop1.frame = CGRectMake(currentRainDrop1.frame.origin.x, weakself.bounds.size.height, currentRainDrop1.frame.size.width, currentRainDrop1.frame.size.height);
        currentRainDrop2.frame = CGRectMake(currentRainDrop2.frame.origin.x, weakself.bounds.size.height, currentRainDrop2.frame.size.width, currentRainDrop2.frame.size.height);
        currentRainDrop3.frame = CGRectMake(currentRainDrop3.frame.origin.x, weakself.bounds.size.height, currentRainDrop3.frame.size.width, currentRainDrop3.frame.size.height);
    } completion:^(BOOL finished) {
        currentRainDrop1.frame = CGRectMake(currentRainDrop1.frame.origin.x, -rainDropHeight, 2, rainDropHeight);
        currentRainDrop2.frame = CGRectMake(currentRainDrop2.frame.origin.x, -rainDropHeight, 2, rainDropHeight);
        currentRainDrop3.frame = CGRectMake(currentRainDrop3.frame.origin.x, -rainDropHeight, 2, rainDropHeight);

        [currentRainDrop1.layer removeAllAnimations];
        [currentRainDrop2.layer removeAllAnimations];
        [currentRainDrop3.layer removeAllAnimations];
        [currentRainDrop4.layer removeAllAnimations];
        
        [currentRainDrop1 removeFromSuperview];
        [currentRainDrop2 removeFromSuperview];
        [currentRainDrop3 removeFromSuperview];
        [currentRainDrop4.layer removeAllAnimations];
    }];
}

- (CENRainDropView *)getRandomRainDrop {
    int randomValue = arc4random_uniform((uint32_t)self._rainDropViews.count);
    
    CENRainDropView *currentRainDrop = [self._rainDropViews objectAtIndex:randomValue];
    if ( currentRainDrop.frame.origin.y != -rainDropHeight ) {
        return [self getRandomRainDrop];
    } else {
        return currentRainDrop;
    }
}

@end

@implementation CENRainDropView

@end
