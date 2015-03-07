//
//  SIAnimatedButton.h
//  Pods
//
//  Created by Christian Otkjær on 06/02/15.
//
//

@import UIKit;

static CGFloat kLineWidthFactor = 1.0/12.0;

@interface SIAnimatedButton : UIControl

@property (nonatomic) CGFloat pointSize;

@property (nonatomic, readonly) CGRect contentFrame;

- (void)contentFrameDidChange;

@end
