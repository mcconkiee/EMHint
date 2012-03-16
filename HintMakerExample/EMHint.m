//
//  EMHintState.m
//  ModalStateOverviewTest
//
//  Created by Eric McConkie on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EMHint.h"

@implementation EMHint
@synthesize hintDelegate;


-(void)_onTap:(UITapGestureRecognizer*)tap
{
    BOOL flag = YES;
    if ([self.hintDelegate respondsToSelector:@selector(hintStateShouldCloseIfPermitted:)]) {
        flag = [self.hintDelegate hintStateShouldCloseIfPermitted:self];
    }
    if(!flag)return;
    if ([self.hintDelegate respondsToSelector:@selector(hintStateWillClose:)]) {
        [self.hintDelegate hintStateWillClose:self];
    }
    
    [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionCurveEaseOut 
                     animations:^(){
                         [_modalView setAlpha:0.0];
                     } 
                     completion:^(BOOL finished){
                         [_modalView removeFromSuperview];
                         _modalView = nil;
                         if ([self.hintDelegate respondsToSelector:@selector(hintStateDidClose:)])
                         {
                             [self.hintDelegate hintStateDidClose:self];
                         }

                     }];
    
}

-(void)clear
{
    [_modalView removeFromSuperview];
    _modalView = nil;
}
-(UIView*)modalView
{
    return _modalView;
}
-(void)_addTap
{
    UITapGestureRecognizer *tap = tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_onTap:)];
    [_modalView addGestureRecognizer:tap]; 
}
-(void)presentModalMessage:(NSString*)message where:(UIView*)presentationPlace
{
    if(_modalView!=nil)
        [_modalView removeFromSuperview];
    
    if ([self.hintDelegate respondsToSelector:@selector(hintStateViewToHint:)]) {
        UIView *v = [self.hintDelegate hintStateViewToHint:self];
        if(v!=nil)
            _modalView = [[EMHintsView alloc] initWithFrame:presentationPlace.frame forView:v];
    }
    
    if ([self.hintDelegate respondsToSelector:@selector(hintStateRectToHint:)]) {
        CGRect rect = [self.hintDelegate hintStateRectToHint:self];
        if (rect.size.width>0 && rect.size.height>0)
            _modalView = [[EMHintsView alloc] initWithFrame:presentationPlace.frame withRect:rect];
    }
    
    if (_modalView==nil)
        [NSException raise:@"No ModalView protocols" 
                    format:@"you must at least implement a view or point "];
    
    [presentationPlace addSubview:_modalView];
    
    UIView *v = nil;
    if ([[self hintDelegate] respondsToSelector:@selector(hintStateViewForDialog:)]) {
        v = [self.hintDelegate hintStateViewForDialog:self];
        [_modalView addSubview:v];
    }
    
    if(v==nil)//no custom subview
    {
        //label
        UIFont *ft = [UIFont fontWithName:@"Helvetica" size:17.0];
        CGSize sz = [message sizeWithFont:ft constrainedToSize:CGSizeMake(250, 1000)];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(floorf(presentationPlace.center.x - sz.width/2),
                                                                   floorf(presentationPlace.center.y - sz.height/2),
                                                                   floorf(sz.width),
                                                                   floorf(sz.height +10
                                                                          ))];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFont:ft];
        [label setText:message];
        [label setTextColor:[UIColor whiteColor]];
        [label setNumberOfLines:0];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        [_modalView addSubview:label];
    }
    
    if ([[self hintDelegate] respondsToSelector:@selector(hintStateHasDefaultTapGestureRecognizer:)]) {
        BOOL flag = [self.hintDelegate hintStateHasDefaultTapGestureRecognizer:self];
        if (flag) {
            [self _addTap];
        }
    }else
    {
        [self _addTap];
    }
   
                                   
}
@end
