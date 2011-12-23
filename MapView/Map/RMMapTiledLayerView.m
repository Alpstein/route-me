//
//  RMMapTiledLayerView.m
//  MapView
//
//  Created by Thomas Rasch on 17.08.11.
//  Copyright (c) 2011 Alpstein. All rights reserved.
//

#import "RMMapTiledLayerView.h"

#import "RMMapView.h"
#import "RMTileSource.h"

@interface RMMapOverlayView ()

- (void)handleDoubleTap:(UIGestureRecognizer *)recognizer;
- (void)handleTwoFingerTap:(UIGestureRecognizer *)recognizer;

@end

@implementation RMMapTiledLayerView

@synthesize delegate;

+ layerClass
{
    return [CATiledLayer class];
}

- (CATiledLayer *)tiledLayer
{  
    return (CATiledLayer *)self.layer;
}

- (id)initWithFrame:(CGRect)frame mapView:(RMMapView *)aMapView
{
    if (!(self = [super initWithFrame:frame]))
        return nil;

    mapView = [aMapView retain];

    self.userInteractionEnabled = YES;
    self.multipleTouchEnabled = YES;
    self.opaque = NO;

    CATiledLayer *tiledLayer = [self tiledLayer];
    tiledLayer.levelsOfDetail = [[mapView tileSource] maxZoom];
    tiledLayer.levelsOfDetailBias = [[mapView tileSource] maxZoom]+1;

    UITapGestureRecognizer *doubleTapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)] autorelease];
    doubleTapRecognizer.numberOfTapsRequired = 2;

    UITapGestureRecognizer *singleTapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)] autorelease];
    [singleTapRecognizer requireGestureRecognizerToFail:doubleTapRecognizer];

    UITapGestureRecognizer *twoFingerTapRecognizer = [[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTwoFingerTap:)] autorelease];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;

    UILongPressGestureRecognizer *longPressRecognizer = [[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)] autorelease];

    [self addGestureRecognizer:singleTapRecognizer];
    [self addGestureRecognizer:doubleTapRecognizer];
    [self addGestureRecognizer:twoFingerTapRecognizer];
    [self addGestureRecognizer:longPressRecognizer];

    return self;
}

- (void)dealloc
{
    [[mapView tileSource] cancelAllDownloads];
    [mapView release]; mapView = nil;
    [super dealloc];
}

- (void)layoutSubviews
{
    self.contentScaleFactor = 1.0f;
}

-(void)drawRect:(CGRect)rect
{
    CGRect bounds = self.bounds;

//    NSLog(@"drawRect: {{%f,%f},{%f,%f}}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);

    short zoom = log2(bounds.size.width / rect.size.width);
    int x = floor(rect.origin.x / rect.size.width), y = floor(fabs(rect.origin.y / rect.size.height));
//    NSLog(@"Tile @ x:%d, y:%d, zoom:%d", x, y, zoom);

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    UIImage *tileImage = [[mapView tileSource] imageForTile:RMTileMake(x, y, zoom) inCache:[mapView tileCache]];
    [tileImage drawInRect:rect];

    [pool release]; pool = nil;
}

#pragma mark -
#pragma mark Event handling

- (void)handleSingleTap:(UIGestureRecognizer *)recognizer
{
    if ([delegate respondsToSelector:@selector(mapTiledLayerView:singleTapAtPoint:)])
        [delegate mapTiledLayerView:self singleTapAtPoint:[recognizer locationInView:mapView]];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state != UIGestureRecognizerStateBegan) return;

    if ([delegate respondsToSelector:@selector(mapTiledLayerView:longPressAtPoint:)])
        [delegate mapTiledLayerView:self longPressAtPoint:[recognizer locationInView:mapView]];
}

- (void)handleDoubleTap:(UIGestureRecognizer *)recognizer
{
    if ([delegate respondsToSelector:@selector(mapTiledLayerView:doubleTapAtPoint:)])
        [delegate mapTiledLayerView:self doubleTapAtPoint:[recognizer locationInView:mapView]];
}

- (void)handleTwoFingerTap:(UIGestureRecognizer *)recognizer
{
    if ([delegate respondsToSelector:@selector(mapTiledLayerView:twoFingerTapAtPoint:)])
        [delegate mapTiledLayerView:self twoFingerTapAtPoint:[recognizer locationInView:mapView]];
}

@end
