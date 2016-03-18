//
//  ViewController.m
//  BubbleTransitionForOC
//
//  Created by Abendas on 16/3/18.
//  Copyright © 2016年 SinceNow. All rights reserved.
//

#import "ViewController.h"
#import "BubbleTransition.h"
#import "ModalViewController.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIButton *transitionButton;
@property (nonatomic, strong) BubbleTransition *transition;
@property (nonatomic, strong) ModalViewController *BTModalViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.transition = [[BubbleTransition alloc] init];
    [self.view addSubview:self.transitionButton];
}

#pragma mark - event reponse

- (void)present {
    [self presentViewController:self.BTModalViewController animated:YES completion:nil];
}

#pragma mark - Transitioning Delegate (Modal)

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    _transition.transitionMode = BubbleTransitionModePresent;
    _transition.startingPoint = _transitionButton.center;
    _transition.bubbleColor = self.transitionButton.backgroundColor;
    return _transition;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    _transition.transitionMode = BubbleTransitionModeDismiss;
    _transition.startingPoint = _transitionButton.center;
    _transition.bubbleColor = self.transitionButton.backgroundColor;
    return _transition;
}

#pragma mark - getters and setters

- (ModalViewController *)BTModalViewController {
    if (!_BTModalViewController) {
        _BTModalViewController = [[ModalViewController alloc] init];
        _BTModalViewController.transitioningDelegate = self;
        _BTModalViewController.modalPresentationStyle = UIModalPresentationCustom;
    }
    return _BTModalViewController;
}

- (UIButton *)transitionButton {
    if (!_transitionButton) {
        _transitionButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 30, self.view.frame.size.height - 80, 60, 60)];
        _transitionButton.backgroundColor = [UIColor blueColor];
        _transitionButton.layer.masksToBounds = YES;
        _transitionButton.layer.cornerRadius = 30;
        [_transitionButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _transitionButton;
}

@end
