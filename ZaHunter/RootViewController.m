//
//  RootViewController.m
//  ZaHunter
//
//  Created by Tewodros Wondimu on 1/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"
#import "Pizzeria.h"

@interface RootViewController () <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate>


@property CLLocationManager *myLocationManager;
@property CLLocation *currentLocation;
@property NSMutableArray *pizzerias;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.myLocationManager = [CLLocationManager new];
    [self.myLocationManager requestWhenInUseAuthorization];
    self.myLocationManager.delegate = self;

    self.currentLocation = [CLLocation new];
    [self.myLocationManager startUpdatingLocation];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
    return cell;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"EROOR %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = locations.firstObject;
    [self.myLocationManager stopUpdatingLocation];
    [self findPizzerias:self.currentLocation];
}

- (void)findPizzerias:(CLLocation *)location
{
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    request.naturalLanguageQuery = @"Pizza";
    request.region = MKCoordinateRegionMake(location.coordinate, MKCoordinateSpanMake(0.09, 0.09));

    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        self.pizzerias = [NSMutableArray arrayWithArray:response.mapItems];
    }];
    NSLog(@"%@\n", [[self.pizzerias firstObject] name]);
}

@end
