//
//  Pizzeria.h
//  ZaHunter
//
//  Created by Tewodros Wondimu on 1/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface Pizzeria : MKMapItem

- (instancetype)initWithPlacemark:(MKPlacemark *)placemark;

@property float longitude;
@property float latitude;
@property CLLocation *location;
@property int timeSpentInMinutes;
@property double rating;
//@property MKPointAnnotation *pin;

@end
