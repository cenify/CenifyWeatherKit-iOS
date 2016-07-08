//
//  CENWeatherStation.m
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/3/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import "CENWeatherStation.h"

@interface CENWeatherStation()

@property (nonatomic) OWMWeatherAPI *_weatherAPI;
@property (nonatomic) CLLocationManager *_locationManager;

@end

@implementation CENWeatherStation
@synthesize temperatureAtCurrentLocation = _temperatureAtCurrentLocation;
@synthesize weatherCondition = _weatherCondition;
@synthesize _weatherConditionId = __weatherConditionId;
@synthesize _weatherAPI = __weatherAPI;
@synthesize _locationManager = __locationManager;

+ (id)sharedManager {
    static CENWeatherStation *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        [sharedManager._locationManager startUpdatingLocation];
    });
                    
    return sharedManager;
}

- (NSNumber *)temperatureAtCurrentLocation {
    if ( !_temperatureAtCurrentLocation ) {
        _temperatureAtCurrentLocation = [[NSNumber alloc] initWithInt:0];
    }
    
    return _temperatureAtCurrentLocation;
}

- (NSNumber *)_weatherConditionId {
    if ( !__weatherConditionId ) {
        __weatherConditionId = [[NSNumber alloc] initWithInt:0];
    }
    
    return __weatherConditionId;
}

- (WeatherCondition)weatherCondition {
    if ( !_weatherCondition ) {
    }
    if ( !self._weatherConditionId ) {
        return WeatherConditionError;
    } else {
        if ( self._weatherConditionId.intValue < 600 ) {
            return WeatherConditionRain;
        } else if ( self._weatherConditionId.intValue < 700 ) {
            return WeatherConditionSnow;
        } else if ( self._weatherConditionId.intValue > 799 && self._weatherConditionId.intValue < 802 ) {
            return WeatherConditionSun;
        } else if ( self._weatherConditionId.intValue < 900 ) {
            return WeatherConditionCloud;
        } else {
            return WeatherConditionSun;
        }
    }
}

- (OWMWeatherAPI *)_weatherAPI {
    if ( !__weatherAPI ) {
        __weatherAPI = [[OWMWeatherAPI alloc] initWithAPIKey:@"5eb23be9558b477430efc31a0c49d18e"];
        
        [__weatherAPI setTemperatureFormat:kOWMTempFahrenheit];
    }
    
    return __weatherAPI;
}

- (CLLocationManager *)_locationManager {
    if ( !__locationManager ) {
        __locationManager = [[CLLocationManager alloc] init];
        
        __locationManager.delegate = self;
        __locationManager.distanceFilter = 100;
        [__locationManager requestAlwaysAuthorization];
        [__locationManager requestWhenInUseAuthorization];
        __locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    }
    
    return __locationManager;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *locationObject = locations.lastObject;
    
    CLLocationCoordinate2D coordinate = locationObject.coordinate;
    
    [self._weatherAPI currentWeatherByCoordinate:coordinate withCallback:^(NSError *error, NSDictionary *result) {
        NSDictionary *main = [result objectForKey:@"main"];
        NSNumber *temp = [main objectForKey:@"temp"];
        
        self.temperatureAtCurrentLocation = temp;
        
        NSArray *weather = [result objectForKey:@"weather"];
        NSNumber *weatherId = [weather.firstObject objectForKey:@"id"];
        
        self._weatherConditionId = weatherId;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TemperatureChangeNotification" object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"ConditionChangeNotification" object:nil];
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSString *errorMessage = [NSString stringWithFormat:@"Error while updating location %@", error.localizedDescription];
    NSLog(@"%@", errorMessage);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [NSNotificationCenter.defaultCenter postNotificationName:CENWeatherKitNotificationStrings.locationManagerAuthorizationChangedString object:nil userInfo:@{@"Status" : [NSNumber numberWithInt:status]}];
}

@end
