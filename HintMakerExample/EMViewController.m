//
//  EMViewController.m
//  HintMakerExample
//
//  Created by Eric McConkie on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EMViewController.h"

@implementation EMViewController

#pragma mark - View lifecycle
-(void)_ui
{
    
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [bt2 setCenter:self.view.center];
    [self.view addSubview:bt2];
    
    
    UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithTitle:@"list" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setRightBarButtonItem:bi];
    [bi release];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];
    [self _ui];
    
   
}

@end
