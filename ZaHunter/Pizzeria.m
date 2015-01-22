//
//  Pizzeria.m
//  ZaHunter
//
//  Created by Tewodros Wondimu on 1/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "Pizzeria.h"

@implementation Pizzeria

- (instancetype)initWithMapItem:(MKMapItem *)item
{
    self = [super init];
    if (self)
    {
        self.pizzariaName = item.placemark.name;
        self.latitude = item.placemark.coordinate.latitude;
        self.longitude = item.placemark.coordinate.longitude;
        self.location = item.placemark.location;
        self.timeSpentInMinutes = 50;
        self.rating = 5;
//        MKPointAnnotation *annotation = [MKPointAnnotation new];
//        self.pin = [annotation ] item.placemark.coordinate
    }
    return self;
}


@end
