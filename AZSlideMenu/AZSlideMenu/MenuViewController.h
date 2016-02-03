//
//  MenuViewController.h
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/22/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate <NSObject>

@optional
- (void)showVCWithIndex:(NSInteger)screenIndex;

@end

@interface MenuViewController : UIViewController

@property (nonatomic, assign) id <MenuViewControllerDelegate>delegate;

@end
