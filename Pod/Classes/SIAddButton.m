//
//  SIAddButton.m
//  Pods
//
//  Created by Christian Otkjær on 06/02/15.
//
//

#import "SIAddButton.h"

@interface SIAddButton ()

@property (nonatomic, strong) CAShapeLayer * verticalBar;
@property (nonatomic, strong) CAShapeLayer * horizontalBar;

@end

@implementation SIAddButton

#pragma mark - Init

- (void)setup
{
    _verticalBar = [CAShapeLayer new];
    _horizontalBar = [CAShapeLayer new];
    
    [self.layer addSublayer:_verticalBar];
    [self.layer addSublayer:_horizontalBar];
    
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    [self updateBars];
    [self updateBarsColor];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    [self setup];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    [self setup];
    
    return self;
}

#pragma mark - Highlighted

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self updateBarsColor];
}

#pragma mark - Selected

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self updateBarsTransformations];
}

#pragma mark - PointSize

- (void)contentFrameDidChange
{
    [super contentFrameDidChange];
    [self updateBars];
}

#pragma mark - Update

- (void)updateBars
{
    CGRect contentFrame = self.contentFrame;
    
    CGFloat barLength = MIN(CGRectGetWidth(contentFrame), CGRectGetHeight(contentFrame));
 
    if (self.pointSize > 0)
    {
        barLength = MIN(self.pointSize, barLength);
    }
    
    CGFloat midX = CGRectGetMidX(contentFrame);
    CGFloat midY = CGRectGetMidY(contentFrame);
    
    CGFloat barWidth = barLength / 8;
    
    UIBezierPath * barPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, barLength, barWidth)
                                                        cornerRadius:barWidth / 2];
    _verticalBar.bounds = [barPath bounds];
    _verticalBar.path = [barPath CGPath];
    _verticalBar.position = CGPointMake(midX, midY);
    
    barPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, barWidth, barLength)
                                         cornerRadius:barWidth / 2];
    
    _horizontalBar.bounds = [barPath bounds];
    _horizontalBar.path = [barPath CGPath];
    _horizontalBar.position = CGPointMake(midX, midY);
}

- (void)updateBarsColor
{
    UIColor * barColor = self.tintColor;
    
    if (self.isHighlighted)
    {
        barColor = [barColor colorWithAlphaComponent:0.5];
    }
    
    _verticalBar.fillColor = [barColor CGColor];
    _horizontalBar.fillColor = [barColor CGColor];
}

- (void)tintColorDidChange
{
    [super tintColorDidChange];
    
    [self updateBarsColor];
}

- (void)updateBarsTransformations
{
    if (self.isSelected)
    {
        self.verticalBar.transform = CATransform3DMakeRotation(M_PI - M_PI / 4, 0, 0, 1);
        self.horizontalBar.transform = CATransform3DMakeRotation(M_PI * 2 - M_PI / 4, 0, 0, 1);
    }
    else
    {
        self.verticalBar.transform = CATransform3DIdentity;
        self.horizontalBar.transform = CATransform3DIdentity;
    }
}

@end
