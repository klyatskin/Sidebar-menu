//
//  ItemBaseViewController.m
//  test
//
//  Created by Konstantin Klyatskin on 2019-12-03.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "ItemBaseViewController.h"

@interface ItemBaseViewController ()

@end

@implementation ItemBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.StringInMenu = @"To be overwritten";
}


- (void)dealloc {
    NSLog(@" %@ (%@) has been deallocated.", self, self.StringInMenu);
}


@end
