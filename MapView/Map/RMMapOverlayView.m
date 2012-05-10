//
//  RMMapOverlayView.m
//  MapView
//
//  Created by Thomas Rasch on 25.08.11.
//  Copyright (c) 2011 Alpstein. All rights reserved.
//

#import "RMMapOverlayView.h"
#import "RMMarker.h"
#import "RMAnnotation.h"
#import "RMPixel.h"

@interface RMMapOverlayView ()



@end

@implementation RMMapOverlayView
{
    CGPoint _lastTranslation;
    RMAnnotation *_draggedAnnotation;
}

@synthesize delegate;

@synthesize lastTranslation = _lastTranslation;
@synthesize draggedAnnotation = _draggedAnnotation;


+ (Class)layerClass
{
    return [CAScrollLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame]))
        return nil;

    self.layer.masksToBounds = YES;
    
    _lastTranslation = CGPointZero;
    _draggedAnnotation = nil;
        
    return self;
}

- (void)dealloc
{
    [_draggedAnnotation release]; _draggedAnnotation = nil;
    [super dealloc];
}

- (unsigned)sublayersCount
{
    return [self.layer.sublayers count];
}

- (void)addSublayer:(CALayer *)aLayer
{
    [self.layer addSublayer:aLayer];
}

- (void)insertSublayer:(CALayer *)aLayer atIndex:(unsigned)index
{
    [self.layer insertSublayer:aLayer atIndex:index];
}

- (void)insertSublayer:(CALayer *)aLayer below:(CALayer *)sublayer
{
    [self.layer insertSublayer:aLayer below:sublayer];
}

- (void)insertSublayer:(CALayer *)aLayer above:(CALayer *)sublayer
{
    [self.layer insertSublayer:aLayer above:sublayer];
}

- (void)moveLayersBy:(CGPoint)delta
{
    [self.layer scrollPoint:CGPointMake(-delta.x, -delta.y)];
}


@end
