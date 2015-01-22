//
//  PizzariaSearch.m
//  ZaHunter
//
//  Created by Chris Giersch on 1/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "PizzariaSearch.h"

@implementation PizzariaSearch

- (void)findPizzarias:(CLLocation *)location
{
    NSMutableArray *pizzarias = [NSMutableArray new];
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"Pizza";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.09, 0.09));

    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error)
    {
        for (MKMapItem *item in response.mapItems)
        {
            Pizzeria *pizzaria = [[Pizzeria alloc] initWithMapItem:item];
            [pizzarias addObject:pizzaria];
        }
        [self.delegate didFinishPizzariaSearchWithMutableArray:pizzarias];
    }];
}

//- (void)orderPizzariasByDistance


@end
