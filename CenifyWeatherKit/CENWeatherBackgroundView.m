//
//  CENWeatherBackgroundView.m
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/11/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import "CENWeatherBackgroundView.h"

@interface CENWeatherBackgroundView()

@property (nonatomic) UIView *_backgroundView;

@end

@implementation CENWeatherBackgroundView
@synthesize _backgroundView = __backgroundView;
@synthesize _weatherCondition = __weatherCondition;

- (void)set_weatherCondition:(WeatherCondition)weatherCondition {
    __weatherCondition = weatherCondition;
    
    [self._backgroundView removeFromSuperview];
    self._backgroundView = nil;
    switch (weatherCondition) {
        case WeatherConditionSun:
            self._backgroundView = [[CENSunnyDayBackgroundView alloc] init];
            break;
        case WeatherConditionRain:
            self._backgroundView = [[CENRainyDayBackgroundView alloc] init];
            break;
        case WeatherConditionCloud:
            self._backgroundView = [[CENCloudyDayBackgroundView alloc] init];
            break;
        case WeatherConditionSnow:
            self._backgroundView = [[CENSnowyDayBackgroundView alloc] init];
            break;
        default:
            self._backgroundView = [[CENSunnyDayBackgroundView alloc] init];
            break;
    }
    
    self._backgroundView.layer.shouldRasterize = YES;
    self._backgroundView.layer.opaque = YES;
    self._backgroundView.layer.drawsAsynchronously = YES;
    self._backgroundView.frame = self.bounds;
    [self addSubview:self._backgroundView];
}

- (UIView *)_backgroundView {
    if ( !__backgroundView ) {
        __backgroundView = [[UIView alloc] init];
    }
    
    return __backgroundView;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setCondition) name:@"ConditionChangeNotification" object:nil];
    
    [self setCondition];
}

- (void)setCondition {
    CENWeatherStation *station = (CENWeatherStation *)[CENWeatherStation sharedManager];
    
    self._weatherCondition = station.weatherCondition;
}

@end
