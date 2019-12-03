//
//  MenuViewController.m
//  test
//
//  Created by Konstantin Klyatskin on 2019-12-02.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "MenuViewController.h"

#import "ItemBaseViewController.h"

//#import "Item1ViewController.h"
//#import "Item2ViewController.h"

@interface MenuViewController () {
    CGFloat _menuWidth;
}
@property (weak, nonatomic) IBOutlet UIView *viewMask;

@property (weak, nonatomic) IBOutlet UIView *viewItems;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMenuWidth;
@property (weak, nonatomic) UIViewController *childVC;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;

@end

@implementation MenuViewController

- (NSArray <NSString *> *)menuItems {
    return @[ @"Item1ViewController",
              @"Item2ViewController",
            ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMenuItemsList];
    [self setupMask];
    [self addMenuItemControllerByClassName:[self menuItems][0]];
}


#pragma mark - Setup

- (void)setupMenuItemsList {
    self.viewItems.clipsToBounds = YES;
    _menuWidth = self.viewItems.bounds.size.width;
}

- (void)setupMask {
    self.viewMask.alpha = 0.0;
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchMenu)];
    [self.viewMask addGestureRecognizer:tapRecognizer];
    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(switchMenu)];
    swipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.viewMask addGestureRecognizer:swipeRecognizer];
}


#pragma mark - Actions

- (IBAction)btnTapped:(id)button {
    NSLog(@"Item choosed: %@", [button titleForState:UIControlStateNormal]);
    [self addMenuItemControllerByClassName:[self menuItems][1]];
}


- (IBAction)menuButtonTapped:(id)button {
    [self switchMenu];
}


#pragma mark - Menu Switch


- (void)switchMenu {
    CGFloat width = (self.viewItems.bounds.size.width > 0) ? 0 : _menuWidth;
    [UIView animateWithDuration:0.3 animations:^{
        self.constraintMenuWidth.constant = width;
        self.viewMask.alpha = width > 0 ? 0.3 : 0.0;
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - Child controllers

- (void)addMenuItemControllerByClassName:(NSString*)className {
  
    [self switchMenu];
    [self removeMenuItemController];

    Class class = NSClassFromString(className);
    UIViewController *vc = [[class alloc] initWithNibName:NSStringFromClass(class) bundle:[NSBundle bundleForClass:class]];
    vc.view.frame = self.viewContainer.bounds;
//    vc.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self addChildViewController:vc];
    [self.viewContainer addSubview:vc.view];
    [vc didMoveToParentViewController:self];
    self.childVC = vc;
    
    [self.view bringSubviewToFront:self.buttonMenu];
}

- (void)removeMenuItemController {
    [self.childVC willMoveToParentViewController:nil];
    [self.childVC.view removeFromSuperview];
    [self.childVC removeFromParentViewController];
}

@end
