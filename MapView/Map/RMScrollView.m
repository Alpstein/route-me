//
//  RMScrollView.m
//  MapView
//
//  Created by Justin Miller on 1/30/12.
//  Copyright (c) 2012 Development Seed. All rights reserved.
//

#import "RMScrollView.h"

@implementation RMScrollView

- (void)setContentOffset:(CGPoint)contentOffset animatedWithDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState & UIViewAnimationCurveEaseInOut
                     animations:^(void)
                     {
                         [super setContentOffset:contentOffset animated:NO];
                     } 
                     completion:nil];
}

- (void)zoomToRect:(CGRect)rect animatedWithDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState & UIViewAnimationCurveEaseInOut
                     animations:^(void)
                     {
                         [super zoomToRect:rect animated:NO];
                     } 
                     completion:nil];
}

@end