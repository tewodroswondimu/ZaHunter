//
//  Pizzeria.m
//  ZaHunter
//
//  Created by Tewodros Wondimu on 1/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Pizzeria.h"

@implementation Pizzeria

- (instancetype)initWithPlacemark:(MKPlacemark *)placemark
{
    self = [super init];
    if (self) {
        self.name = placemark.name;
        self.latitude = placemark.coordinate.latitude;
        self.longitude = placemark.coordinate.longitude;
        self.location = placemark.location;
        self.timeSpentInMinutes = 50;
        self.rating = 5;
    }
    return self;
}

@end
