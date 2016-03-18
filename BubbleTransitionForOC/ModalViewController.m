//
//  ModalViewController.m
//  BubbleTransitionForOC
//
//  Created by Abendas on 16/3/18.
//  Copyright © 2016年 SinceNow. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()

@property (nonatomic, strong) UIButton *transitionButton;

@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.transitionButton];

}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

#pragma mark - event reponse

- (void)present {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - getters and setters

- (UIButton *)transitionButton {
    if (!_transitionButton) {
        _transitionButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 30, self.view.frame.size.height - 80, 60, 60)];
        _transitionButton.backgroundColor = [UIColor redColor];
        _transitionButton.layer.masksToBounds = YES;
        _transitionButton.layer.cornerRadius = 30;
        [_transitionButton addTarget:self action:@selector(present) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _transitionButton;
}

@end
