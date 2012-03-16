//
//  EMViewController.h
//  HintMakerExample
//
//  Created by Eric McConkie on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMHint.h"


@interface EMViewController : UIViewController<EMHintDelegate>
{
    EMHint *_hint;
}

@end
