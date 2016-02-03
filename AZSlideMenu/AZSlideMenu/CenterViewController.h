//
//  CenterViewController.h
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/20/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"

@protocol CenterViewControllerDelegate <NSObject>

@optional
- (void)movePanelRight;

@required
-(void)movePanelToOriginalPosition;

@end

@interface CenterViewController : UIViewController

@property (nonatomic, assign) id <CenterViewControllerDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;

@property (nonatomic, retain) LeftViewController *leftVC;

@end
