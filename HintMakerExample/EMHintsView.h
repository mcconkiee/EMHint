//
//  EMHintView.h
//  ModalStateOverviewTest
//
//  Created by Eric McConkie on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EMHintsView : UIView
{
    CGPoint _position;
    CGFloat _radius;
}
- (id)initWithFrame:(CGRect)frame forView:(UIView*)onView;
- (id)initWithFrame:(CGRect)frame withRect:(CGRect)aRect;
@end
