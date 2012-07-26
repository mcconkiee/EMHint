//
//  EMViewController.m
//  HintMakerExample
//
//  Created by Eric McConkie on 3/16/12.
/*
Copyright (c) 2012 Eric McConkie

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "EMViewController.h"

@implementation EMViewController
#pragma mark ---------------------------------->> 
#pragma mark -------------->>hint deleage

-(NSArray*)hintStateViewsToHint:(id)hintState
{
    return [[NSArray alloc] initWithObjects:_info, nil];
}
-(UIView*)hintStateViewForDialog:(id)hintState
{
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 50)];
    
    [l setBackgroundColor:[UIColor clearColor]];
    [l setTextColor:[UIColor whiteColor]];
    [l setText:@"I am the info button!"];
    return l;
}
#pragma mark ---------------------------------->> 
#pragma mark -------------->>private
-(void)_onTap:(id)sender
{
    [_hint presentModalMessage:@"One last hint for ya." where:self.view];
}
#pragma mark - View lifecycle

-(void)_ui
{
    
    
    UIButton *bt2 = [UIButton buttonWithType:UIButtonTypeInfoDark];
    [bt2 setCenter:self.view.center];
    [bt2 addTarget:self action:@selector(_onTap:) forControlEvents:UIControlEventTouchUpInside];
    _info =bt2;
    [self.view addSubview:bt2];
    
    
    UIBarButtonItem *bi = [[UIBarButtonItem alloc] initWithTitle:@"list" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [self.navigationItem setRightBarButtonItem:bi];
    [bi release];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self _ui];
    
    _hint = [[EMHint alloc] init];
    [_hint setHintDelegate:self];
    
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

@end
