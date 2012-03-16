//
//  HintHelper.h
//  HintMakerExample
//
//  Created by Eric McConkie on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMHint.h"
#import "EMViewController.h"
#define  kFirstMessage @"Spotlights to help lead your users...Tap along."
typedef enum
{
    EMHintDialogTypeIntro,
    EMHintDialogTypeInfo,
    EMHintDialogTypeButton,
    EMHintDialogTypeList,
    EMHintDialogTypeBack,
    EMHintDialogTypeCount
}EMHintDialogType;


@interface HintHelper : NSObject<EMHintDelegate>
{
    EMHintDialogType _curType;    
    EMHint *modalState;
    UIViewController *_vc;
}
- (id)initWithViewController:(UIViewController*)vc;
@end
