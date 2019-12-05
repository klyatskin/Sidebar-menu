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

+ (NSString *)stringInMenu {
    return @"Item 1";
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnTapped:(UIButton *)button {
    NSLog(@"Button tapped: %@", [button titleForState:UIControlStateNormal]);
}

@end
