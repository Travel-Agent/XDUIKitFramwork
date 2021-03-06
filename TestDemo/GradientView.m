//
//  GradientView.m
//  XDCalenderViewDemo
//
//  Created by admin on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GradientView.h"

@interface GradientView ()

- (void) drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors;

@end


@implementation GradientView

@synthesize colors = _colors;

- (id)initWithFrame:(CGRect)frame withColors:(NSArray *)colors;
{
    if(self = [super initWithFrame:frame]){
        
        _colors =  [[NSMutableArray arrayWithArray:colors] retain];
        
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setColors:(NSMutableArray *)colors
{
    if(_colors){
        [_colors release];
        _colors = nil;
    }
    _colors = [colors retain];
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    if(_colors && _colors.count>0){
        [self drawGradientInRect:rect withColors:_colors]; 
    }
}

- (void) drawGradientInRect:(CGRect)rect withColors:(NSArray*)colors{
	
	NSMutableArray *ar = [NSMutableArray array];
	for(UIColor *c in colors){
		[ar addObject:(id)c.CGColor];
	}
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
	
	
	
	CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
	CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
	
    
	CGContextClipToRect(context, rect);
	
	CGPoint start = CGPointMake(0.0, 0.0);
	CGPoint end = CGPointMake(0.0, rect.size.height);
	
	CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
	
	CGGradientRelease(gradient);
	CGContextRestoreGState(context);
}


- (void)dealloc
{
    [_colors release];
    [super dealloc];
}

@end
