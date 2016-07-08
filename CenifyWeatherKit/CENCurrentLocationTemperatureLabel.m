//
//  CENCurrentLocationTemperatureLabel.m
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/3/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import "CENCurrentLocationTemperatureLabel.h"
#import "CENWeatherStation.h"

@implementation CENCurrentLocationTemperatureLabel

- (void)awakeFromNib {
    [super awakeFromNib];

    self.text = [NSString stringWithFormat:@"--%@", DEGREES_SYMBOL];
    [self setUpTemperature];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
        
    self.text = [NSString stringWithFormat:@"--%@", DEGREES_SYMBOL];
    self.textAlignment = NSTextAlignmentCenter;
    [self setUpTemperature];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(temperatureDidChange) name:@"TemperatureChangeNotification" object:nil];
}

- (void)temperatureDidChange {
    [self setUpTemperature];
}

- (void)setUpTemperature {
    CENWeatherStation *station = (CENWeatherStation *)[CENWeatherStation sharedManager];
    NSNumber *currentTemperature = station.temperatureAtCurrentLocation;
    
    self.text = [NSString stringWithFormat:@"%i%@", currentTemperature.intValue, DEGREES_SYMBOL];
}

@end
