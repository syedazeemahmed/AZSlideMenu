//
//  LeftViewController.m
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/20/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import "LeftViewController.h"
#import "DashboardViewController.h"

@interface LeftViewController ()
- (IBAction)ShowDashboard:(id)sender;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 
- (IBAction)ShowDashboard:(id)sender {
    UIButton *button = sender;
    [_delegate showViewControllerOfMyChoice:button.tag];
}
@end
