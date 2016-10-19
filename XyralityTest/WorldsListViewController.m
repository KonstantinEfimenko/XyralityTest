//
//  ViewController.m
//  XyralityTest
//
//  Created by Konstantin Efimenko on 10/18/16.
//  Copyright © 2016 Efimenko Ink. All rights reserved.
//

#import "WorldsListViewController.h"
#import "WorldsCollection.h"

@interface WorldsListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WorldsListViewController
{
    WorldsCollection *worldsCollection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contentWasChanged:) name:XyralityTestWorldsListContentWasChanged object:nil];
    worldsCollection = [WorldsCollection sharedInstance];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)contentWasChanged:(id)object{
    [_tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return worldsCollection.worlds.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorldItemCell"];
    cell.textLabel.text = worldsCollection.worlds[indexPath.row][@"name"];
    return cell;
}

- (IBAction)onLogOutButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"login" sender:self];
}

- (IBAction)onRefreshButtonPressed:(id)sender {
}

@end
