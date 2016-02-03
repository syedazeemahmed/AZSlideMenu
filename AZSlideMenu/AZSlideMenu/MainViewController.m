//
//  MainViewController.m
//  AZSlideMenu
//
//  Created by Syed Azeem Ahmed on 1/20/16.
//  Copyright © 2016 Syed Azeem Ahmed. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "CenterViewController.h"
#import "MenuViewController.h"

#import "DashboardViewController.h"
#import "ProfileViewController.h"

#define CENTER_TAG 1
#define LEFT_PANEL_TAG 2
#define RIGHT_PANEL_TAG 3

#define CORNER_RADIUS 4

#define SLIDE_TIMING .25
#define PANEL_WIDTH 60


@interface MainViewController () <CenterViewControllerDelegate , UIGestureRecognizerDelegate, MenuViewControllerDelegate>

@property (nonatomic, strong) CenterViewController *centerViewController;
@property (nonatomic, strong) MenuViewController *menuPanelViewController;
@property (nonatomic, assign) BOOL showingLeftPanel;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self showVCWithIndex:0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupView {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.centerViewController = (CenterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"CenterViewController"];
    self.centerViewController.view.tag = CENTER_TAG;
    self.centerViewController.delegate = self;
    [self.view addSubview:self.centerViewController.view];
    [self addChildViewController:_centerViewController];
    [_centerViewController didMoveToParentViewController:self];

    [self setupGestures];
}

-(void)showCenterViewWithShadow:(BOOL)value withOffset:(double)offset {
    if (value) {
        [_centerViewController.view.layer setCornerRadius:CORNER_RADIUS];
        [_centerViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_centerViewController.view.layer setShadowOpacity:0.8];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];

    } else {
        [_centerViewController.view.layer setCornerRadius:0.0f];
        [_centerViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

-(void)resetMainView {
    // remove left and right views, and reset variables, if needed
    if (_menuPanelViewController != nil) {
        [self.menuPanelViewController.view removeFromSuperview];
        self.menuPanelViewController = nil;
        _centerViewController.leftButton.tag = 1;
        self.showingLeftPanel = NO;
    }
    // remove view shadows
    [self showCenterViewWithShadow:NO withOffset:0];
}

-(UIView *)getLeftView {
    // init view if it doesn't already exist
    if (_menuPanelViewController == nil)
    {
        // this is where you define the view for the left panel
        self.menuPanelViewController = [[MenuViewController alloc] initWithNibName:@"MenuView" bundle:nil];
        self.menuPanelViewController.view.tag = LEFT_PANEL_TAG;
        self.menuPanelViewController.delegate = self;

        [self.view addSubview:self.menuPanelViewController.view];

        [self addChildViewController:_menuPanelViewController];
        [_menuPanelViewController didMoveToParentViewController:self];

        _menuPanelViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }

    self.showingLeftPanel = YES;

    // setup view shadows
    [self showCenterViewWithShadow:YES withOffset:-2];

    UIView *view = self.menuPanelViewController.view;
    return view;
}

#pragma mark -
#pragma mark Swipe Gesture Setup/Actions

#pragma mark - setup

-(void)setupGestures {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];

    [_centerViewController.view addGestureRecognizer:panRecognizer];
}

-(void)movePanel:(id)sender {
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];

    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];

    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;

        if(velocity.x > 0) {
                childView = [self getLeftView];
        }
        // make sure the view we're working with is front and center
        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }

    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {


        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        }
        else {
                [self movePanelRight];
            }
    }

    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {
        if (_centerViewController.view.frame.origin.x>=0) {

            // are we more than halfway, if so, show the panel when done dragging by setting this value to YES (1)
            _showPanel = fabs([sender view].center.x - _centerViewController.view.frame.size.width/2) > _centerViewController.view.frame.size.width/2;

            // allow dragging only in x coordinates by only updating the x coordinate with translation position
            [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
            [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];

            // if you needed to check for a change in direction, you could use this code to do so
            if(velocity.x*_preVelocity.x + velocity.y*_preVelocity.y > 0) {
//                NSLog(@"same direction");
            } else {
//                NSLog(@"opposite direction");
            }
            
            _preVelocity = velocity;
        }
    }
}

#pragma mark -
#pragma mark Delegate Actions
-(void)movePanelRight {
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];

    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _centerViewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             _centerViewController.leftButton.tag = 0;
                         }
                     }];
}

-(void)movePanelToOriginalPosition {
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _centerViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self resetMainView];
                         }
                     }];
}

#pragma mark Menu Delegate
- (void)showVCWithIndex:(NSInteger)screenIndex {

    [self removeCurrentViewFromBaseVC];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *yourViewController = nil;

    switch (screenIndex) {
        case 0:
            yourViewController = (ProfileViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
             break;
        case 1:
            yourViewController = (DashboardViewController *)[storyboard instantiateViewControllerWithIdentifier:@"DashboardViewController"];
            break;

        default:
            break;
    }


    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:yourViewController];

    [self.centerViewController.view addSubview:navigationController.view];
    [self.centerViewController addChildViewController:navigationController];
    [navigationController didMoveToParentViewController:self.centerViewController ];

    [self movePanelToOriginalPosition];
    
}

- (void)removeCurrentViewFromBaseVC {

    if ([[_centerViewController childViewControllers] count] > 0) {
        UIViewController *vc = [_centerViewController.childViewControllers lastObject];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}
@end
