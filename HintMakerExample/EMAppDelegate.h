//
//  EMAppDelegate.h
//  HintMakerExample
//
//  Created by Eric McConkie on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HintHelper.h" 
@class EMViewController;

@interface EMAppDelegate : UIResponder <UIApplicationDelegate>
{
    HintHelper *_hintHelper;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) EMViewController *viewController;

@end
