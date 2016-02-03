//
//  DashboardViewController.m
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/21/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import "DashboardViewController.h"
#import "MainViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self.navigationItem setTitle:@"Dashboard"];
}

@end
