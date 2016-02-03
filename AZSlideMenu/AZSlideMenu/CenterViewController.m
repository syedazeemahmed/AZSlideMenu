//
//  CenterViewController.m
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/20/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import "CenterViewController.h"

@interface CenterViewController () 


- (IBAction)menuButtonPressed:(id)sender;
@end

@implementation CenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

//    [[self navigationController] setNavigationBarHidden:NO animated:YES];

}

- (IBAction)menuButtonPressed:(id)sender {
    UIButton *button = sender;
    switch (button.tag) {
        case 0: {
            [_delegate movePanelToOriginalPosition];
            break;
        }

        case 1: {
            [_delegate movePanelRight];
            break;
        }

        default:
            break;
    }
}

@end
