//
//  PizzariaSearch.h
//  ZaHunter
//
//  Created by Chris Giersch on 1/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pizzeria.h"
#import <MapKit/MapKit.h>

@protocol PizzariaSearchDelegate <NSObject>

- (void)didFinishPizzariaSearchWithMutableArray:(NSMutableArray *)array;

@end

@interface PizzariaSearch : NSObject

@property (nonatomic, weak) id<PizzariaSearchDelegate> delegate;

- (void)findPizzarias:(CLLocation *)location;



@end
