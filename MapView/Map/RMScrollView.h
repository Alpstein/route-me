//
//  RMScrollView.h
//  MapView
//
//  Created by Justin Miller on 1/30/12.
//  Copyright (c) 2012 Development Seed. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMScrollView : UIScrollView

- (void)setContentOffset:(CGPoint)contentOffset animatedWithDuration:(NSTimeInterval)duration;
- (void)zoomToRect:(CGRect)rect animatedWithDuration:(NSTimeInterval)duration;

@end