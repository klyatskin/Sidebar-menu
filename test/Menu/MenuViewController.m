//
//  MenuViewController.m
//  test
//
//  Created by Konstantin Klyatskin on 2019-12-02.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "MenuViewController.h"

#import "ItemBaseViewController.h"


@interface MenuViewController () {
    CGFloat _menuWidth;
    NSUInteger _indexSelected;
}
@property (weak, nonatomic) IBOutlet UIView *viewMask;
@property (weak, nonatomic) IBOutlet UIStackView *viewStack;

@property (weak, nonatomic) IBOutlet UIView *viewItems;
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraintMenuWidth;
@property (weak, nonatomic) UIViewController *childVC;
@property (weak, nonatomic) IBOutlet UIButton *buttonMenu;

@end

@implementation MenuViewController

- (NSArray <NSString *> *)menuItems {
    return @[
        @"Item3ViewController",   // Logout
        @"Item1ViewController",
        @"Item2ViewController",
    ];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewItems.clipsToBounds = YES;
    _menuWidth = self.viewItems.bounds.size.width;
    [self setupMenuItemsList];
    [self setupMask];
    // load 1st controller
    _indexSelected = 0;
    [self addMenuItemControllerByClassName:[self menuItems][_indexSelected]];
}


#pragma mark - Setup

- (void)setupMenuItemsList {
    
    NSUInteger index = 0;
    CGRect frame = self.viewStack.bounds;
    frame.size.height = 40;
    
    for ( NSString *className in [self menuItems]) {
       
        Class class = NSClassFromString(className);
        ItemBaseViewController *vc = [[class alloc] init];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self
                   action:@selector(btnTapped:)
         forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:vc.stringInMenu forState:UIControlStateNormal];
        button.backgroundColor = [UIColor lightGrayColor];
        button.frame = frame;
        button.tag = index;
        [self.viewStack insertArrangedSubview:button atIndex:index++];
    }


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

- (IBAction)btnTapped:(UIButton *)button {
//    NSLog(@"Item choosed: %@, tag: %ld", [button titleForState:UIControlStateNormal], (long)button.tag);
    if (button.tag == _indexSelected) {
        [self switchMenu];
        return;
    }
    _indexSelected = button.tag;
    [self addMenuItemControllerByClassName:[self menuItems][_indexSelected]];
}


- (IBAction)menuButtonTapped:(id)button {
    [self switchMenu];

}


#pragma mark - Menu Switch


- (void)switchMenu {
    CGFloat width = (self.viewItems.bounds.size.width > 0) ? 0 : _menuWidth;
    [UIView animateWithDuration:0.3
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.constraintMenuWidth.constant = width;
                         self.viewMask.alpha = width > 0 ? 0.3 : 0.0;
                         [self.view layoutIfNeeded];
                     } completion:^(BOOL finished) {
                     }
     ];
}

#pragma mark - Child controllers

- (void)addMenuItemControllerByClassName:(NSString*)className {
  
    [self switchMenu];
    [self removeMenuItemController];

    Class class = NSClassFromString(className);
    UIViewController *vc = [[class alloc] initWithNibName:NSStringFromClass(class) bundle:[NSBundle bundleForClass:class]];
    vc.view.frame = self.viewContainer.bounds;
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


- (void)dealloc {
//    NSLog(@"MenuViewController deallocated.");
}

@end
