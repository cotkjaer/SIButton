//
//  SIAnimatedButton.m
//  Pods
//
//  Created by Christian Otkjær on 06/02/15.
//
//

#import "SIAnimatedButton.h"

@implementation SIAnimatedButton

#pragma mark - PointSize

- (void)setPointSize:(CGFloat)pointSize
{
    if (_pointSize != pointSize)
    {
        CGRect contentFrame = self.contentFrame;
    
        _pointSize = pointSize;
        
        if (!CGRectEqualToRect(self.contentFrame, contentFrame))
        {
            [self contentFrameDidChange];
        }
    }
}

- (void)setBounds:(CGRect)bounds
{
    CGRect contentFrame = self.contentFrame;
    
    [super setBounds:bounds];
    
    if (!CGRectEqualToRect(contentFrame, self.contentFrame))
    {
        [self contentFrameDidChange];
    }
}

#pragma mark - contentFrame

- (void)contentFrameDidChange
{
    // NOOP - override
}

- (CGRect)contentFrame
{
    CGFloat barLength = MIN(CGRectGetWidth(self.bounds),
                            CGRectGetHeight(self.bounds));
    
    if (self.pointSize > 0)
    {
        barLength = MIN(self.pointSize, barLength);
    }
    
    CGFloat minX = 0;
    CGFloat minY = 0;
    
    
    switch (self.contentHorizontalAlignment)
    {
        case UIControlContentHorizontalAlignmentFill:
        case UIControlContentHorizontalAlignmentCenter:
            minX = CGRectGetMidX(self.bounds) - barLength / 2;
            break;
            
        case UIControlContentHorizontalAlignmentLeft:
            minX = CGRectGetMinX(self.bounds);
            break;
            
        case UIControlContentHorizontalAlignmentRight:
            minX = CGRectGetMaxX(self.bounds) - barLength;
            break;
            
        default:
            break;
    }
    
    switch (self.contentVerticalAlignment)
    {
        case UIControlContentVerticalAlignmentFill:
        case UIControlContentVerticalAlignmentCenter:
            minY = CGRectGetMidY(self.bounds) - barLength / 2;
            break;
            
        case UIControlContentVerticalAlignmentTop:
            minY = CGRectGetMinY(self.bounds);
            break;

        case UIControlContentVerticalAlignmentBottom:
            minY = CGRectGetMaxY(self.bounds) - barLength;
            break;
            
        default:
            break;
    }
 
    return CGRectMake(minX, minY, barLength, barLength);
}

@end
