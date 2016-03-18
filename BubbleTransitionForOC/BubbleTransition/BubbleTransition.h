//
//  BubbleTransition.h
//  BubbleTransitionForOC
//
//  Created by Abendas on 16/3/18.
//  Copyright © 2016年 SinceNow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 The possible directions of the transition.
 
 - BubbleTransitionModePresent: For presenting a new modal controller
 - BubbleTransitionModeDismiss: For dismissing the current controller
 - BubbleTransitionModePop: For a pop animation in a navigation controller
 */

typedef NS_ENUM(NSInteger, BubbleTransitionMode) {
    BubbleTransitionModePresent,
    BubbleTransitionModeDismiss,
    BubbleTransitionModePop
};

@interface BubbleTransition : NSObject <UIViewControllerAnimatedTransitioning>

/**
 The point that originates the bubble. The bubble starts from this point
 and shrinks to it on dismiss
 */
@property (nonatomic, assign) CGPoint startingPoint;

/**
 The transition duration. The same value is used in both the Present or Dismiss actions
 Defaults to `0.5`
 */
@property (nonatomic, assign) NSTimeInterval duration;

/**
 The transition direction. Possible values `BubbleTransitionModePresent`, `BubbleTransitionModeDismiss` or `BubbleTransitionModePop`
 Defaults to `BubbleTransitionModePresent`
 */
@property (nonatomic, assign) BubbleTransitionMode transitionMode;

/**
 The color of the bubble. Make sure that it matches the destination controller's background color.
 */
@property (nonatomic, assign) UIColor *bubbleColor;

@property (nonatomic, strong) UIView *bubble;

/**
 Required by UIViewControllerAnimatedTransitioning
 */
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>) transitionContext;

/**
 Required by UIViewControllerAnimatedTransitioning
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext;

@end
