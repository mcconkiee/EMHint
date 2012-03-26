//
//  EMHintView.m
//  ModalStateOverviewTest
//
//  Created by Eric McConkie on 3/6/12.
/*
Copyright (c) 2012 Eric McConkie

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

#import "EMHintsView.h"
#import <QuartzCore/QuartzCore.h>

#define BACKGROUND_ALPHA 0.70

@implementation EMHintsView

- (id)initWithFrame:(CGRect)frame withRect:(CGRect)aRect
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _position = CGPointMake(aRect.origin.x,
                                aRect.origin.y);
        _radius = aRect.size.width;
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:BACKGROUND_ALPHA]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame forView:(UIView*)onView
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _position = CGPointMake(onView.frame.origin.x + (onView.frame.size.width/2)
                                , onView.frame.origin.y + (onView.frame.size.height/2)  );
        _radius = onView.frame.size.width;
        [self setBackgroundColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:BACKGROUND_ALPHA]];
    }
    return self;
}

-(void)_background:(CGRect)rect
{
    CGPoint c = _position;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGImageRef backgroundimage = CGBitmapContextCreateImage(context);
    CGContextClearRect(context, rect);
    //CGContextDrawImage(context, rect, backgroundimage); 
    
    // Draw the masking image 
    CGContextSaveGState(context);
    
    //flip the context (right-sideup)
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);     
    
    //colors/components/locations
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat black[4] = {0.0,0.0,0.0,BACKGROUND_ALPHA};
    CGFloat white[4] = {1.0,1.0,1.0,1.0};//clear
    
    CGFloat components[8] = {
        
        white[0],white[1],white[2],white[3],        
        black[0],black[1],black[2],black[3],
    };
    
    CGFloat colorLocations[2] = {0.25,0.5};
    
    //create the gradient Ref
    CGGradientRef gradientRef = CGGradientCreateWithColorComponents(colorspace, components, colorLocations, 2);
    CGColorSpaceRelease(colorspace);
    
    //draw the shape
    CGFloat radius =_radius;
    CGMutablePathRef path = CGPathCreateMutable();
    //
    //draw a rect around view
    CGPathAddRect(path, NULL, CGRectMake(c.x - _radius, c.y -radius,100,100));
    CGPathAddLineToPoint(path, NULL, c.x +_radius, c.y  - _radius);
    CGPathAddLineToPoint(path, NULL, c.x +_radius, c.y + _radius);
    CGPathAddLineToPoint(path, NULL, c.x - _radius, c.y + _radius);
    CGPathAddLineToPoint(path, NULL, c.x - _radius, c.y);
    CGPathAddLineToPoint(path, NULL, c.x, c.y);
    /*
     
     //draw a rectangle like spotlight --- i'll get to this later
     CGPathMoveToPoint(path, NULL, c.x-radius, c.y-radius);
     CGPathAddLineToPoint(path, NULL, c.x, c.y-radius);
     CGPathAddArcToPoint(path, NULL, c.x+radius, c.y-radius, c.x+radius, c.y, radius);
     CGPathAddArcToPoint(path, NULL, c.x+radius, c.y +radius, c.x , c.y+radius, radius);
     CGPathAddArcToPoint(path, NULL, c.x -radius, c.y + radius, c.x-radius, c.y, radius);
     CGPathAddArcToPoint(path, NULL, c.x-radius, c.y - radius, c.x, c.y-radius, radius);
     CGContextAddPath(context, path);    
     CGContextClip(context);
     
     //fill with gradient
     CGContextDrawRadialGradient(context, gradientRef, c, 0.0f, c, _radius*2, 0);
     
     
     */
    
    
    CGContextAddPath(context, path);  
    CGPathRelease(path);
    CGContextClip(context);
    
    //add gradient
    CGContextDrawRadialGradient(context, gradientRef, c, 0.0f, c, _radius*2, 0);
    CGGradientRelease(gradientRef);
    CGContextRestoreGState(context);
    
    //convert drawing to image for masking
    CGImageRef maskImage = CGBitmapContextCreateImage(context);
    CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskImage), 
                                        CGImageGetHeight(maskImage), 
                                        CGImageGetBitsPerComponent(maskImage), 
                                        CGImageGetBitsPerPixel(maskImage), 
                                        CGImageGetBytesPerRow(maskImage), 
                                        CGImageGetDataProvider(maskImage), NULL, FALSE);
    
    
    //mask the background image
    CGImageRef masked = CGImageCreateWithMask(backgroundimage, mask);
    CGImageRelease(backgroundimage);
    //remove the spotlight gradient now that we have it as image
    CGContextClearRect(context, rect);
    
    //draw the transparent background with the mask
    CGContextDrawImage(context, rect, masked);
    
    CGImageRelease(maskImage);
    CGImageRelease(mask);
    CGImageRelease(masked);
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [self _background:rect];
}


@end
