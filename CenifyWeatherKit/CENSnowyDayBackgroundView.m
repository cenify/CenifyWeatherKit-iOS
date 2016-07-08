//
//  CENSnowyDayBackgroundView.m
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 12/19/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import "CENSnowyDayBackgroundView.h"

@interface CENSnowyDayBackgroundView ()

@property (nonatomic) NSMutableArray *_snowflakeViews;

@end

@implementation CENSnowyDayBackgroundView

@synthesize _snowflakeViews = __snowflakeViews;

int snowflakeSize = 8;

- (NSArray *)_snowflakeViews {
    if ( !__snowflakeViews ) {
        __snowflakeViews = [[NSMutableArray alloc] init];
        
        for ( int i = 0; i < self.bounds.size.height / 4; i++ ) {
            CENSnowflakeView *snowflake = [[CENSnowflakeView alloc] initWithFrame:CGRectMake((i * 4) + snowflakeSize, -snowflakeSize, snowflakeSize, snowflakeSize)];
            snowflake.image = [UIImage imageNamed:@"Snowflake" inBundle:[NSBundle bundleForClass:[CENSnowyDayBackgroundView class]] compatibleWithTraitCollection:nil];
            snowflake.alpha = 0.3;
            snowflake.layer.drawsAsynchronously = YES;
            snowflake.layer.opaque = YES;
            snowflake.layer.shouldRasterize = YES;
            snowflake.layer.allowsGroupOpacity = NO;
            
            [__snowflakeViews addObject:snowflake];
        }
    }
    
    return __snowflakeViews;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setUpBackgroundImage];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(setUpRainDropAnimations) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setUpBackgroundImage {
    UIImage *backgroundImage = [UIImage imageNamed:@"SnowyDayBackground" inBundle:[NSBundle bundleForClass:[CENSnowyDayBackgroundView class]] compatibleWithTraitCollection:nil];
    
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    
    backgroundImageView.image = backgroundImage;
    [self addSubview:backgroundImageView];
}

- (void)setUpRainDropAnimations {
    __weak typeof(self) weakself = self;
    
    CENSnowflakeView *currentSnowflake1 = [weakself getRandomSnowflake];
    
    CENSnowflakeView *currentSnowflake2 = [weakself getRandomSnowflake];
    
    CENSnowflakeView *currentSnowflake3 = [weakself getRandomSnowflake];
    
    [weakself addSubview:currentSnowflake1];
    [weakself addSubview:currentSnowflake2];
    [weakself addSubview:currentSnowflake3];
    
    CENSnowflakeView *currentSnowflake4;
    
    int largeSnowflakeRandomValue = arc4random_uniform(20);
    if ( largeSnowflakeRandomValue == 10 ) {
        currentSnowflake4 = [weakself getRandomSnowflake];
        currentSnowflake4.frame = CGRectMake(currentSnowflake4.frame.origin.x, currentSnowflake4.frame.origin.y, 20, 20);
        [weakself addSubview:currentSnowflake4];
        
        [UIView animateWithDuration:2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            currentSnowflake4.frame = CGRectMake(currentSnowflake4.frame.origin.x - self.bounds.size.width, weakself.bounds.size.height, currentSnowflake4.frame.size.width, currentSnowflake4.frame.size.height);
        } completion:^(BOOL finished) {
            
            currentSnowflake4.frame = CGRectMake(currentSnowflake4.frame.origin.x + self.bounds.size.width, -snowflakeSize, snowflakeSize, snowflakeSize);
            
            [currentSnowflake4 removeFromSuperview];
            [currentSnowflake4.layer removeAllAnimations];
            [self._snowflakeViews addObject:currentSnowflake4];
        }];
    }
    
    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        currentSnowflake1.frame = CGRectMake(currentSnowflake1.frame.origin.x - self.bounds.size.height / 2, weakself.bounds.size.height, currentSnowflake1.frame.size.width, currentSnowflake1.frame.size.height);
        currentSnowflake2.frame = CGRectMake(currentSnowflake2.frame.origin.x - self.bounds.size.height / 2, weakself.bounds.size.height, currentSnowflake2.frame.size.width, currentSnowflake2.frame.size.height);
        currentSnowflake3.frame = CGRectMake(currentSnowflake3.frame.origin.x - self.bounds.size.height / 2, weakself.bounds.size.height, currentSnowflake3.frame.size.width, currentSnowflake3.frame.size.height);
    } completion:^(BOOL finished) {
        currentSnowflake1.frame = CGRectMake(currentSnowflake1.frame.origin.x + self.bounds.size.height / 2, -snowflakeSize, snowflakeSize, snowflakeSize);
        currentSnowflake2.frame = CGRectMake(currentSnowflake2.frame.origin.x + self.bounds.size.height / 2, -snowflakeSize, snowflakeSize, snowflakeSize);
        currentSnowflake3.frame = CGRectMake(currentSnowflake3.frame.origin.x + self.bounds.size.height / 2, -snowflakeSize, snowflakeSize, snowflakeSize);
        
        [currentSnowflake1.layer removeAllAnimations];
        [currentSnowflake2.layer removeAllAnimations];
        [currentSnowflake3.layer removeAllAnimations];
        
        [currentSnowflake1 removeFromSuperview];
        [currentSnowflake2 removeFromSuperview];
        [currentSnowflake3 removeFromSuperview];
        
        [self._snowflakeViews addObject:currentSnowflake1];
        [self._snowflakeViews addObject:currentSnowflake2];
        [self._snowflakeViews addObject:currentSnowflake3];
    }];
}

- (CENSnowflakeView *)getRandomSnowflake {
    int randomValue = arc4random_uniform((uint32_t)self._snowflakeViews.count);
    
    CENSnowflakeView *currentSnowflake = [self._snowflakeViews objectAtIndex:randomValue];
    [self._snowflakeViews removeObject:currentSnowflake];

    return currentSnowflake;
}

@end

@implementation CENSnowflakeView

@end