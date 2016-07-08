//
//  CENSunnyDayView.m
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/10/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import "CENSunnyDayBackgroundView.h"

@interface CENSunnyDayBackgroundView()

///Left most cloud
@property (nonatomic) UIImageView *_cloud1;

///Right most cloud
@property (nonatomic) UIImageView *_cloud2;

///Upper middle cloud
@property (nonatomic) UIImageView *_cloud3;

@end

@implementation CENSunnyDayBackgroundView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self setUpBackgroundImage];
    [self setUpClouds];
    [self setUpCloudAnimations];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeAnimation:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

///Restores animation when app is resumed
- (void)resumeAnimation:(NSNotification *)notification {
    [self setUpClouds];
    [self setUpCloudAnimations];
}

- (void)setUpBackgroundImage {
    UIImage *backgroundImage = [UIImage imageNamed:@"SunnyDayBackground" inBundle:[NSBundle bundleForClass:[CENSunnyDayBackgroundView class]] compatibleWithTraitCollection:nil];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];

    backgroundImageView.image = backgroundImage;
    [self addSubview:backgroundImageView];
}

///Places clouds on screen
- (void)setUpClouds {
    [self setUpCloud1];
    [self setUpCloud2];
    [self setUpCloud3];
}


///Sets up first left most cloud
- (void)setUpCloud1 {
    UIImage *cloudImage1 = [UIImage imageNamed:@"SunnyDayCloud1" inBundle:[NSBundle bundleForClass:[CENSunnyDayBackgroundView class]] compatibleWithTraitCollection:nil];
    
    self._cloud1 = [[UIImageView alloc] init];
    self._cloud1.image = cloudImage1;
    self._cloud1.frame = CGRectMake(-300, 50, 300, 200);
    [self addSubview:self._cloud1];
}

///Sets up first left most cloud
- (void)setUpCloud2 {
    UIImage *cloudImage2 = [UIImage imageNamed:@"SunnyDayCloud2" inBundle:[NSBundle bundleForClass:[CENSunnyDayBackgroundView class]] compatibleWithTraitCollection:nil];
    
    self._cloud2 = [[UIImageView alloc] init];
    self._cloud2.image = cloudImage2;
    self._cloud2.frame = CGRectMake(self.bounds.size.width, 100, 300, 180);
    [self addSubview:self._cloud2];
}

///Sets up first left most cloud
- (void)setUpCloud3 {
    UIImage *cloudImage3 = [UIImage imageNamed:@"SunnyDayCloud3" inBundle:[NSBundle bundleForClass:[CENSunnyDayBackgroundView class]] compatibleWithTraitCollection:nil];
    
    self._cloud3 = [[UIImageView alloc] init];
    self._cloud3.image = cloudImage3;
    self._cloud3.frame = CGRectMake(self.bounds.size.width / 2 - 150, 150, 300, 160);
    [self addSubview:self._cloud3];
}

///Launches cloud animations
- (void)setUpCloudAnimations {
    [self setUpCloudAnimation1];
    [self setUpCloudAnimation2];
    [self setUpCloudAnimation3];
}

///Sets up cloud 1 animation
///Resets cloud to starting point, moves it to the other end, then restarts the animation
- (void)setUpCloudAnimation1 {
    [UIView animateWithDuration:50 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        self._cloud1.frame = CGRectMake(self.bounds.size.width, self._cloud1.frame.origin.y, self._cloud1.frame.size.width, self._cloud1.bounds.size.height);
    } completion:^(BOOL finished) {
    }];
}

///Sets up cloud 2 animation
///Resets cloud to starting point, moves it to the other end, then restarts the animation
- (void)setUpCloudAnimation2 {
    [UIView animateWithDuration:40 delay:0 options:UIViewAnimationOptionRepeat animations:^{
        self._cloud2.frame = CGRectMake(-self._cloud2.frame.size.width, self._cloud2.frame.origin.y, self._cloud2.frame.size.width, self._cloud2.bounds.size.height);
    } completion:^(BOOL finished) {
    }];
}

///Sets up cloud 3 animation
///Moves it from middle to right most end, resets it on the left most end, then restarts the animation
- (void)setUpCloudAnimation3 {
    [UIView animateWithDuration:60 delay:0 options:0 animations:^{
        self._cloud3.frame = CGRectMake(-self._cloud3.frame.size.width, self._cloud3.frame.origin.y, self._cloud3.frame.size.width, self._cloud3.bounds.size.height);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:60 delay:0 options:UIViewAnimationOptionRepeat animations:^{
            self._cloud3.frame = CGRectMake(self.bounds.size.width, self._cloud3.frame.origin.y, self._cloud3.frame.size.width, self._cloud3.bounds.size.height);
        } completion:^(BOOL finished) {
        }];
    }];
}


@end
