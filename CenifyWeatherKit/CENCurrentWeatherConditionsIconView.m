//
//  CENCurrentWeatherConditionsIconView.m
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/4/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import "CENCurrentWeatherConditionsIconView.h"

@interface CENCurrentWeatherConditionsIconView()

@property (nonatomic) WeatherCondition _weatherCondition;
@property (nonatomic) UIImageView *_conditionsImageView;

@end

@implementation CENCurrentWeatherConditionsIconView
@synthesize darkModeEnabled = _darkModeEnabled;
@synthesize _weatherCondition = __weatherCondition;
@synthesize _conditionsImageView = __conditionsImageView;

- (void)setWeatherCondition:(WeatherCondition)weatherCondition {
    __weatherCondition = weatherCondition;
    
    switch (weatherCondition) {
        case WeatherConditionSun:
            self._conditionsImageView.image = [UIImage imageNamed:@"SunnyIcon" inBundle:[NSBundle bundleForClass:[CENCurrentWeatherConditionsIconView class]] compatibleWithTraitCollection:nil];
            break;
        case WeatherConditionRain:
            self._conditionsImageView.image = [UIImage imageNamed:@"RainIcon" inBundle:[NSBundle bundleForClass:[CENCurrentWeatherConditionsIconView class]] compatibleWithTraitCollection:nil];
            break;
        case WeatherConditionCloud:
            self._conditionsImageView.image = [UIImage imageNamed:@"CloudIcon" inBundle:[NSBundle bundleForClass:[CENCurrentWeatherConditionsIconView class]] compatibleWithTraitCollection:nil];
            break;
        case WeatherConditionSnow:
            self._conditionsImageView.image = [UIImage imageNamed:@"SnowIcon" inBundle:[NSBundle bundleForClass:[CENCurrentWeatherConditionsIconView class]] compatibleWithTraitCollection:nil];
            break;
        default:
            break;
    }
    
    [self toggleImageColor];
}

- (UIImageView *)_conditionsImageView {
    if ( !__conditionsImageView ) {
        __conditionsImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    
    return __conditionsImageView;
}

/*- (void)setDarkModeEnabled:(BOOL)darkModeEnabled {
    _darkModeEnabled = darkModeEnabled;
    
    [self toggleImageColor];
}*/

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    [self addSubview:self._conditionsImageView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCondition) name:@"ConditionChangeNotification" object:nil];
    
    [self setCondition];
}

- (void)setCondition {
    CENWeatherStation *station = (CENWeatherStation *)[CENWeatherStation sharedManager];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 2 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"%@", [NSString stringWithFormat:@"WEATHER IMAGE ID: %i", [station._weatherConditionId intValue]]);
    });

    self.weatherCondition = station.weatherCondition;
}

- (void)toggleImageColor {
    if ( self.darkModeEnabled ) {
        [self._conditionsImageView tintImage:[UIColor blackColor]];
    } else {
        [self._conditionsImageView tintImage:[UIColor whiteColor]];

    }
}

@end
