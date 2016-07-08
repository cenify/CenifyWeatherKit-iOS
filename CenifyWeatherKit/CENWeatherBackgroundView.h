//
//  CENWeatherBackgroundView.h
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/11/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CENSunnyDayBackgroundView.h"
#import "CENRainyDayBackgroundView.h"
#import "CENSnowyDayBackgroundView.h"
#import "CENCloudyDayBackgroundView.h"
#import "CENWeatherStation.h"

@interface CENWeatherBackgroundView : UIView

@property (nonatomic) WeatherCondition _weatherCondition;

@end
