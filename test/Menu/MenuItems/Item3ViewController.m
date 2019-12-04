//
//  Item3ViewController.m
//  test
//
//  Created by Konstantin Klyatskin on 2019-12-03.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "Item3ViewController.h"

@interface Item3ViewController ()

@end

@implementation Item3ViewController


- (NSString *)stringInMenu {
    return @"Logout";
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)btnTapped:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
