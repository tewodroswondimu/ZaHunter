//
//  RootViewController.m
//  ZaHunter
//
//  Created by Tewodros Wondimu on 1/21/15.
//  Copyright (c) 2015 MobileMakers. All rights reserved.
//

#import "RootViewController.h"
#import "Pizzeria.h"
#import "PizzariaSearch.h"

@interface RootViewController () <CLLocationManagerDelegate, UITableViewDataSource, UITableViewDelegate, PizzariaSearchDelegate>


@property CLLocationManager *myLocationManager;
@property CLLocation *currentLocation;
@property NSMutableArray *pizzerias;
@property PizzariaSearch *pizzariaSearch;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Set up PizzariaSearch object so we can search for pizzarias
    self.pizzariaSearch = [PizzariaSearch new];
    self.pizzariaSearch.delegate = self;
    // Set up LocationManager object
    self.myLocationManager = [CLLocationManager new];
    [self.myLocationManager requestWhenInUseAuthorization];
    self.myLocationManager.delegate = self;

    self.currentLocation = [CLLocation new];
    [self.myLocationManager startUpdatingLocation];
}


//-----------------------------    Reorder Pizzarias    ----------------------------------
#pragma mark - Other
- (void)setDistanceFromCurrentLocation:(Pizzeria *)location
{
    location.distanceFromCurrentLocation = [location.location distanceFromLocation:self.currentLocation];
}


//-------------------------------    Pizzaria Search    ----------------------------------
#pragma mark - Pizzaria Search
- (void)didFinishPizzariaSearchWithMutableArray:(NSMutableArray *)array
{
    self.pizzerias = [NSMutableArray arrayWithArray:array];
    for (Pizzeria *pizzaria in self.pizzerias)
    {
        [self setDistanceFromCurrentLocation:pizzaria];
    }

    NSSortDescriptor *firstDescriptor = [[NSSortDescriptor alloc] initWithKey:@"distanceFromCurrentLocation" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:firstDescriptor];

    [self.pizzerias sortUsingDescriptors:sortDescriptors];
    [self.tableView reloadData];
}

//---------------------------------    Table View    ----------------------------------
#pragma mark - Table View
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
//    return self.pizzerias.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    Pizzeria *currentPizzaria = [self.pizzerias objectAtIndex:indexPath.row];
    cell.textLabel.text = [currentPizzaria pizzariaName];
    float currentDistance = [[currentPizzaria location] distanceFromLocation:self.currentLocation];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%f km", currentDistance/1000];
    return cell;
}

//-------------------------------    Location Manager    --------------------------------
#pragma mark - Location Manager
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    self.currentLocation = locations.firstObject;
    if (self.currentLocation != nil)
    {
        [self.myLocationManager stopUpdatingLocation];
        [self.pizzariaSearch findPizzarias:self.currentLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"EROOR %@", error);
}

@end
