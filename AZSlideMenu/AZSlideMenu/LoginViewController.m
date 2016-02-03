//
//  LoginViewController.m
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/20/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "CenterViewController.h"

@interface LoginViewController ()
- (IBAction)signInNow:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
//    [[self navigationController] setNavigationBarHidden:YES animated:YES];

}

- (IBAction)signInNow:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *yourViewController = (MainViewController *)[storyboard instantiateViewControllerWithIdentifier:@"MainVC"];
    [self.navigationController pushViewController:yourViewController animated:YES];

}
@end
