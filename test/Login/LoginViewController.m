//
//  LoginViewController.m
//  test
//
//  Created by Konstantin Klyatskin on 2019-12-02.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginAnimator.h"
#import "MenuViewController.h"

@interface LoginViewController ()

@property (strong,nonatomic) LoginAnimator *animator;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animator = [LoginAnimator new];
}

- (IBAction)btnTaped:(UIButton *)sender {
    
    MenuViewController *mvc =[[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    mvc.modalPresentationStyle = UIModalPresentationCustom;
//    mvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    mvc.transitioningDelegate = (id <UIViewControllerTransitioningDelegate>)self.animator;
    [self presentViewController:mvc animated:YES completion:nil];
}

- (void)dealloc {
    NSLog(@"❌ - LoginViewController deallocated.");
}

@end
