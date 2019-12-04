//
//  LoginAnimator.m
//  test
//
//  Created by Konstantin Klyatskin on 2019-12-03.
//  Copyright © 2019 Konstantin Klyatskin. All rights reserved.
//

#import "LoginAnimator.h"


@interface LoginAnimator () <UIViewControllerAnimatedTransitioning> {
    
}


@end

@implementation LoginAnimator

// https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/CustomizingtheTransitionAnimations.html
// https://github.com/pronebird/CustomModalTransition/blob/ios8/CustomModalTransition/ModalTransitionAnimator.m#L87

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return self;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}
 


- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    UIViewController* destination = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    Boolean presented = [destination isBeingPresented];
    if (presented)
        [self animatePresentingInContext:transitionContext toVC:toVC fromVC:fromVC];
    else
        [self animateDismissingInContext:transitionContext toVC:toVC fromVC:fromVC];
}



- (void)animatePresentingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC {
    CGRect fromVCRect = [transitionContext initialFrameForViewController:fromVC];
    CGRect toVCRect = fromVCRect;
    toVCRect.origin.x = toVCRect.size.width;

    toVC.view.frame = toVCRect;
    UIView *container = [transitionContext containerView];
    [container addSubview:toVC.view];
    
    [UIView animateWithDuration:1.0
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        toVC.view.frame = fromVCRect;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

- (void)animateDismissingInContext:(id<UIViewControllerContextTransitioning>)transitionContext toVC:(UIViewController *)toVC fromVC:(UIViewController *)fromVC {
    __block CGRect fromVCRect = [transitionContext initialFrameForViewController:fromVC];
    fromVCRect.origin.x = fromVCRect.size.width - 15; // make a small bounce...

    [UIView animateWithDuration:1.0
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
        fromVC.view.frame = fromVCRect;
    } completion:^(BOOL finished) {
        fromVCRect.origin.x = fromVCRect.size.width;
        [UIView animateWithDuration:0.3
                         animations: ^{  // hide bounce...
            fromVC.view.frame = fromVCRect;
        } completion:^(BOOL finished) {
            [fromVC.view removeFromSuperview];
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }];
}
@end
