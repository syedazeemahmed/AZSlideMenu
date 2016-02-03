//
//  LeftViewController.h
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/20/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LeftViewControllerDelegate <NSObject>

@optional
- (void)showViewControllerOfMyChoice:(NSInteger)screenIndex;

@end

@interface LeftViewController : UIViewController

@property (nonatomic, assign) id <LeftViewControllerDelegate>delegate;

@end
