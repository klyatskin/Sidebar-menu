//
//  ItemOneViewController.m
//  test
//
//  Created by Konstantin Klyatskin on 2019-12-02.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "Item1ViewController.h"

@interface Item1ViewController ()

@end

@implementation Item1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.StringInMenu = @"Item 1";
}

- (IBAction)btnTapped:(UIButton *)button {
    NSLog(@"Button tapped: %@", [button titleForState:UIControlStateNormal]);
}

@end
