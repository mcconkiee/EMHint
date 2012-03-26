//
//  HintHelper.m
//  HintMakerExample
//
//  Created by Eric McConkie on 3/16/12.
/*
Copyright (c) 2012 Eric McConkie

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "HintHelper.h"

@implementation HintHelper
#pragma mark ---------------------------------->> 
#pragma mark -------------->>modal delegate
-(void)doNext
{
    switch (_curType) {
        case EMHintDialogTypeInfo:
            [modalState presentModalMessage:@"Info button! \r\nProtocol: returned rect" where:_vc.navigationController.view];
            break;
        case EMHintDialogTypeButton:
            [modalState presentModalMessage:@"Here is a simpl black overlay without a spotlight. \r\nProtocol: returned  rect" where:_vc.navigationController.view];
            break;    
        case EMHintDialogTypeList:
            [modalState presentModalMessage:@"This is a list button! \r\nProtocol: returned rect" where:_vc.navigationController.view];
            break;
        default:
            [modalState presentModalMessage:@"" where:_vc.navigationController.view];
            break;
    }
}

#pragma mark ---------------------------------->> 
#pragma mark -------------->>HInt Delegate
-(BOOL)hintStateShouldCloseIfPermitted:(id)hintState
{
    _curType ++;
    
    if(_curType>=EMHintDialogTypeCount)
    {
        _curType = 0;//reset for next time
        return YES;
    }
    [self doNext];
    return NO;
}
-(void)hintStateWillClose:(id)hintState
{
    NSLog(@"i am about to close: %@",hintState);
}
-(void)hintStateDidClose:(id)hintState
{
    NSLog(@"i closed: %@",hintState);
}




-(CGRect)hintStateRectToHint:(id)hintState
{
    CGFloat ht = 50.0;
    CGFloat statusBarHt = 20.0;
    CGRect rect;
    switch (_curType) {
        case EMHintDialogTypeInfo:
            rect = CGRectMake(_vc.view.frame.size.width/2 ,
                              _vc.view.frame.size.height/2 + (statusBarHt + 44),
                              ht,ht);
            break;
        case EMHintDialogTypeList:
            rect = CGRectMake(290, ht/2 + statusBarHt,ht,ht);
            break;
        case EMHintDialogTypeBack:
            rect= CGRectMake(25, ht/2 + statusBarHt,ht,ht);
            break;
        case EMHintDialogTypeButton:
            rect = CGRectMake(0, 0, 1, 1);
            break;
        default:
            rect = CGRectMake(0, 0, 1, 1);
            break;
    }
    return rect;
}


-(UIView*)hintStateViewForDialog:(id)hintState
{
    if (_curType == EMHintDialogTypeBack) {
        //label
        NSString *icon = @"\u267C";
        UIFont *ft = [UIFont fontWithName:@"Arial" size:150.0];
        CGSize sz = [icon sizeWithFont:ft constrainedToSize:CGSizeMake(250, 1000)];
        UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(floorf(_vc.view.center.x - sz.width/2),
                                                                    _vc.view.center.y - sz.height/2,
                                                                    floorf(sz.width),
                                                                    floorf(sz.height +10
                                                                           ))] autorelease];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextAlignment:UITextAlignmentCenter];
        [label setFont:ft];   
        [label setTextColor:[UIColor greenColor]];
        [label setText:icon];//icon
        [label setNumberOfLines:0];
        [label setLineBreakMode:UILineBreakModeWordWrap];
        
        return label;
    }
    return nil;
}
- (id)initWithViewController:(UIViewController*)vc {
    self = [super init];
    if (self) {
        _vc = vc;
        _curType = EMHintDialogTypeIntro;
        
        // Do any additional setup after loading the view, typically from a nib.
        modalState = [[EMHint alloc] init];
        [modalState setHintDelegate:self];
        [modalState presentModalMessage:kFirstMessage where:_vc.navigationController.view];
    }
    return self;
}

- (void)dealloc {
    
    [modalState release];
    [super dealloc];
}

@end
