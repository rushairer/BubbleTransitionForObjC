//
//  BubbleTransition.m
//  BubbleTransitionForOC
//
//  Created by Abendas on 16/3/18.
//  Copyright © 2016年 SinceNow. All rights reserved.
//

#import "BubbleTransition.h"

@implementation BubbleTransition

- (instancetype)init {
    self = [super init];
    if (self) {
        self.duration = 0.5f;
        self.transitionMode = BubbleTransitionModePresent;
        self.bubbleColor = [UIColor whiteColor];
        self.startingPoint = CGPointZero;
    }
    
    return self;
}

#pragma mark - public methods

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = [transitionContext containerView];
    if (containerView == nil) {
        return;
    }
    if (self.transitionMode == BubbleTransitionModePresent) {
        UIView *presentedControllerView = [transitionContext viewForKey:UITransitionContextToViewKey];
        CGPoint originalCenter = presentedControllerView.center;
        CGSize originalSize = presentedControllerView.frame.size;
        
        self.bubble = [[UIView alloc] init];
        self.bubble.frame = [self frameForBubble:originalCenter size:originalSize start:self.startingPoint];
        self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2;
        self.bubble.center = self.startingPoint;
        self.bubble.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
        self.bubble.backgroundColor = self.bubbleColor;
        [containerView addSubview:self.bubble];
        
        presentedControllerView.center = self.startingPoint;
        presentedControllerView.transform = CGAffineTransformMakeScale(0.001f, 0.001f);
        presentedControllerView.alpha = 0;
        [containerView addSubview:presentedControllerView];
        
        [UIView animateWithDuration:self.duration animations:^{
            self.bubble.transform = CGAffineTransformIdentity;
            presentedControllerView.transform = CGAffineTransformIdentity;
            presentedControllerView.alpha = 1;
            presentedControllerView.center = originalCenter;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        
        NSString *key = (self.transitionMode == BubbleTransitionModePop) ? UITransitionContextToViewKey : UITransitionContextFromViewKey;
        UIView *returningControllerView = [transitionContext viewForKey:key];
        CGPoint originalCenter = returningControllerView.center;
        CGSize originalSize = returningControllerView.frame.size;
        
        self.bubble.frame = [self frameForBubble:originalCenter size:originalSize start:self.startingPoint];
        self.bubble.layer.cornerRadius = self.bubble.frame.size.height / 2;
        self.bubble.center = self.startingPoint;
 
        [UIView animateWithDuration:self.duration animations:^{
            self.bubble.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returningControllerView.transform = CGAffineTransformMakeScale(0.001, 0.001);
            returningControllerView.alpha = 0;
            returningControllerView.center = self.startingPoint;
            
            if (self.transitionMode == BubbleTransitionModePop) {
                [containerView insertSubview:returningControllerView belowSubview:returningControllerView];
                [containerView insertSubview:self.bubble belowSubview:returningControllerView];
            }
        } completion:^(BOOL finished) {
            returningControllerView.center = originalCenter;
            [returningControllerView removeFromSuperview];
            [self.bubble removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
    }
}

#pragma mark - private methods

- (CGRect)frameForBubble:(CGPoint) originalCenter size:(CGSize) originalSize start:(CGPoint) start {
    CGFloat lengthX = fmax(start.x, originalSize.width - start.x);
    CGFloat lengthY = fmax(start.y, originalSize.height - start.y);
    CGFloat offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2;
    
    return CGRectMake(CGPointZero.x, CGPointZero.y, offset, offset);
}

#pragma mark - getters and setters

- (CGPoint)startingPoint {
    self.bubble.center = _startingPoint;
    return _startingPoint;
}

@end
