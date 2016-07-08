//
//  CENWeatherStation.h
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/3/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWMWeatherAPI.h"
#import "CENWeatherKitNotificationStrings.h"

#define DEGREES_SYMBOL @"°"

typedef NS_ENUM(NSInteger, WeatherCondition) {
    
    WeatherConditionSun,
    WeatherConditionRain,
    WeatherConditionCloud,
    WeatherConditionSnow,
    WeatherConditionError
};

@interface CENWeatherStation : NSObject <CLLocationManagerDelegate>

@property (nonatomic) NSNumber *temperatureAtCurrentLocation;
@property (nonatomic) WeatherCondition weatherCondition;
@property (nonatomic) NSNumber *_weatherConditionId;


+ (id)sharedManager;

@end