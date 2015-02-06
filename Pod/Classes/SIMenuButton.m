//
//  SIMenuButton.m
//  Pods
//
//  Created by Christian Otkjær on 06/02/15.
//
//

#import "SIMenuButton.h"

@interface SIMenuButton ()

@property (nonatomic, strong) CAShapeLayer * topBar;
@property (nonatomic, strong) CAShapeLayer * middleBar;
@property (nonatomic, strong) CAShapeLayer * bottomBar;

@end

@implementation SIMenuButton

#pragma mark - Init

- (void)setup
{
    _topBar = [CAShapeLayer new];
    _middleBar = [CAShapeLayer new];
    _bottomBar = [CAShapeLayer new];
    
    [self.layer addSublayer:_topBar];
    [self.layer addSublayer:_middleBar];
    [self.layer addSublayer:_bottomBar];
    
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

#pragma mark - 

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
    
    CGFloat barWidth = barLength / 8;
    
    UIBezierPath * barPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, barLength, barWidth)
                                                        cornerRadius:barWidth / 2];
    _topBar.bounds = [barPath bounds];
    _topBar.path = [barPath CGPath];
    _topBar.position = CGPointMake(CGRectGetMidX(contentFrame), CGRectGetMinY(contentFrame) + barWidth / 2);
    
    _middleBar.bounds = [barPath bounds];
    _middleBar.path = [barPath CGPath];
    _middleBar.position = CGPointMake(CGRectGetMidX(contentFrame), CGRectGetMidY(contentFrame));
    
    _bottomBar.bounds = [barPath bounds];
    _bottomBar.path = [barPath CGPath];
    _bottomBar.position = CGPointMake(CGRectGetMidX(contentFrame), CGRectGetMaxY(contentFrame) - barWidth / 2);

    /*
    CGFloat barLength = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    CGFloat barWidth = barLength / 8;
    
    UIBezierPath * barPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, barLength, barWidth)
                                                        cornerRadius:barWidth / 2];
    _topBar.bounds = [barPath bounds];
    _topBar.path = [barPath CGPath];
    _topBar.position = CGPointMake(CGRectGetMidX(self.bounds), barWidth / 2);
    
    _middleBar.bounds = [barPath bounds];
    _middleBar.path = [barPath CGPath];
    _middleBar.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    
    _bottomBar.bounds = [barPath bounds];
    _bottomBar.path = [barPath CGPath];
    _bottomBar.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) - barWidth / 2);
     */
}

- (void)updateBarsColor
{
    UIColor * barColor = self.tintColor;
    
    if (self.isHighlighted)
    {
        barColor = [barColor colorWithAlphaComponent:0.5];
    }
    
    _topBar.fillColor = [barColor CGColor];
    _middleBar.fillColor = [barColor CGColor];
    _bottomBar.fillColor = [barColor CGColor];
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
        CGRect contentFrame = self.contentFrame;
        
        self.middleBar.transform = self.selected ? CATransform3DMakeRotation(M_PI / 2, 0, 1, 0): CATransform3DIdentity;
        self.middleBar.opacity = 0;
        
        self.topBar.transform = CATransform3DConcat(CATransform3DMakeRotation(M_PI / 4, 0, 0, 1), CATransform3DMakeTranslation(0, CGRectGetMidY(contentFrame) - CGRectGetMidY(self.topBar.frame), 0));
        
        self.bottomBar.transform = CATransform3DConcat(CATransform3DMakeRotation(- M_PI / 4, 0, 0, 1), CATransform3DMakeTranslation(0, CGRectGetMidY(contentFrame) - CGRectGetMidY(self.bottomBar.frame), 0));
    }
    else
    {
        self.middleBar.opacity = 1;
        self.topBar.transform = CATransform3DIdentity;
        self.middleBar.transform = CATransform3DIdentity;
        self.bottomBar.transform = CATransform3DIdentity;
    }
}


@end
