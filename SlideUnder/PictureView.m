//
//  PictureView.m
//  SlideUnder
//
//  Created by Tommaso Piazza on 3/17/12.
//  Copyright (c) 2012 ChalmersTH. All rights reserved.
//

#import "PictureView.h"

@implementation PictureView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIView* view = [[touches anyObject] view];
    [self.superview bringSubviewToFront:view];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UIView* view = [[touches anyObject] view];
    
    UITouch *aTouch = [touches anyObject];
    CGPoint loc = [aTouch locationInView:view];
    CGPoint prevloc = [aTouch previousLocationInView:view];
    
    float deltaX = loc.x - prevloc.x;
    float deltaY = loc.y - prevloc.y;
    
    self.transform = CGAffineTransformTranslate(self.transform, deltaX, deltaY);
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

-(BOOL) canBecomeFirstResponder {
    
    return  YES;
}

-(BOOL) becomeFirstResponder {
    
    return  YES;
}

@end
