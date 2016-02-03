//
//  MenuViewController.m
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/22/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
- (IBAction)ShowDashboard:(id)sender;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)ShowDashboard:(id)sender {
    UIButton *button = sender;
    [_delegate showVCWithIndex:button.tag];
}
@end
