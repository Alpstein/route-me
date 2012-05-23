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
- (void)handleTwoFingerDoubleTap:(UIGestureRecognizer *)recognizer;

@end

@implementation RMMapTiledLayerView

@synthesize delegate;
@synthesize useSnapshotRenderer;

+ (Class)layerClass
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

    self.useSnapshotRenderer = NO;

    CATiledLayer *tiledLayer = [self tiledLayer];
    tiledLayer.levelsOfDetail = [[mapView tileSource] maxZoom];
    tiledLayer.levelsOfDetailBias = [[mapView tileSource] maxZoom];

    return self;
}

- (void)dealloc
{
    [[mapView tileSource] cancelAllDownloads];
    [mapView release]; mapView = nil;
    [super dealloc];
}

- (void)didMoveToWindow
{
    self.contentScaleFactor = 1.0f;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context
{
    CGRect rect   = CGContextGetClipBoundingBox(context);
    CGRect bounds = self.bounds;
    short zoom    = log2(bounds.size.width / rect.size.width);

//    NSLog(@"drawLayer: {{%f,%f},{%f,%f}}", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    if (self.useSnapshotRenderer)
    {
        zoom = (short)ceilf(mapView.adjustedZoomForRetinaDisplay);
        CGFloat rectSize = bounds.size.width / powf(2.0, (float)zoom);

        int x1 = floor(rect.origin.x / rectSize),
            x2 = floor((rect.origin.x + rect.size.width) / rectSize),
            y1 = floor(fabs(rect.origin.y / rectSize)),
            y2 = floor(fabs((rect.origin.y + rect.size.height) / rectSize));

//        NSLog(@"Tiles from x1:%d, y1:%d to x2:%d, y2:%d @ zoom %d", x1, y1, x2, y2, zoom);

        UIGraphicsPushContext(context);

        for (int x=x1; x<=x2; ++x)
        {
            for (int y=y1; y<=y2; ++y)
            {
                UIImage *tileImage = [[mapView tileSource] imageForTile:RMTileMake(x, y, zoom) inCache:[mapView tileCache]];
                [tileImage drawInRect:CGRectMake(x * rectSize, y * rectSize, rectSize, rectSize)];
            }
        }

        UIGraphicsPopContext();
    }
    else
    {
        int x = floor(rect.origin.x / rect.size.width),
            y = floor(fabs(rect.origin.y / rect.size.height));

//        NSLog(@"Tile @ x:%d, y:%d, zoom:%d", x, y, zoom);

        UIGraphicsPushContext(context);

        UIImage *tileImage = [[mapView tileSource] imageForTile:RMTileMake(x, y, zoom) inCache:[mapView tileCache]];
        [tileImage drawInRect:rect];

        UIGraphicsPopContext();
    }

    [pool release]; pool = nil;
}


@end
