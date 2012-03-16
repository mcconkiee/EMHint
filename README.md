# EMHint

## Overview

**EMHint** is an iOS class group that easily adds a spotlight-like effect to a view. The protocols of EMHintDelegate allow users to override many of the default actions.



####  Installation

1. Drop in EMHint (.h/.m) & EMHintsView (.h/.m)
2. Pick a logical place to manage EMHintDelegate protocol implementation and conform to `<EMHintDelegate>` .
3. \#import "EMHint.h"
3. Call a new hint using the instance method `presentModalMessage:(NSString*)message where:(UIView*)presentationPlace`
3. You must implement `(CGRect)hintStateRectToHint:(id)hintState` **OR** `-(UIView*)hintStateViewToHint:(id)hintState` - without one, you will throw an exception. By doing so, EMHint can understand the radius of the spotlight to draw, and where-abouts.


See the example app (`HintMakerExample`)in this build for more.
#### Tips
1. It's possible to "daisy chain" hints. See the `HintHelper.m` class for a quick overview of using enums and protocol methods
2. Custom views can be added inplace of the default white text. Useful if you need to add a view or label not at center, or any custom graphics, etc
3. return CGRectMake(0,0,1,1) for an all black bg without spotlight….CGRectZero will fail.


#### Todo's (limitations)
1. add rectangular spotlight  (and other shapes)
2. different background colors/alpha/etc
3. support rotation (currently only label and background do so)







