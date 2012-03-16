//
//  EMHintState.h
//  ModalStateOverviewTest
//
//  Created by Eric McConkie on 3/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMHintsView.h"

typedef enum
{
    EMHintShapeTypeRound,
    EMHintShapeTypeRectangle
}EMHintShapeType;

@protocol EMHintDelegate <NSObject>

@optional

-(BOOL)hintStateHasDefaultTapGestureRecognizer:(id)hintState ;



/*
 // return a view where the spotlight should shine     
 */
-(UIView*)hintStateViewToHint:(id)hintState;

/*
 // the default hint space is a label with white helvetica text dynamically centered,
 // one can return a custom view here to override that label
 */
-(UIView*)hintStateViewForDialog:(id)hintState;

/*
 // return a rect for where the spotlight should shine.
 // convenient if a UIView is not an option
 */
-(CGRect)hintStateRectToHint:(id)hintState;

/*
 // return NO, if you plan to daisy chain hints, or do someother action
 // return YES, to fad out modal hint view
 */
-(BOOL) hintStateShouldCloseIfPermitted:(id)hintState ;

/*
 // called just before the close (fade) of a modal state view     
 */
-(void) hintStateWillClose:(id)hintState ;

/*
 // called immediately after the modal hint view has faded to zero alpha and is removed     
 */
-(void) hintStateDidClose:(id)hintState ;





/*
 // Default hint is a round spotlight effect,
 // TODO:// rectangle type can be returned to override
 */
//-(EMHintShapeType)hintStateShapeType:(id)hintState;


@end

@interface EMHint : NSObject
{
    EMHintsView *_modalView;//our transparent hint window with lablel and spotlight
}
@property (nonatomic,assign) id<EMHintDelegate> hintDelegate;

-(UIView*)modalView; // accessor to the modal view (use spareingly)
-(void)clear;//instant removal of modal view

/*
 //initiates the modal hint view 
 //default is a spotlight effect on the UIView or Rect returned from one of the protocol methods
 // message is the message in the label
 // where is the view onto which the modal will overlay
 */
-(void)presentModalMessage:(NSString*)message where:(UIView*)presentationPlace;
@end
