//
//  Item2ViewController.m
//  test
//
//  Created by Konstantin Klyatskin on 2019-12-02.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "Item2ViewController.h"

@interface Item2ViewController ()

@end

@implementation Item2ViewController

- (NSString *)stringInMenu {
    return @"Item 2";
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnTapped:(UIButton *)button {
    NSLog(@"Button tapped: %@", [button titleForState:UIControlStateNormal]);
}


@end
