//
//  DrawerView.m
//  DrawingComponent
//
//  Created by zein rezky chandra on 10/07/24.
//

#import "DrawerView.h"

@implementation DrawerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.image = nil;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self.image drawInRect:rect];
}

/*
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the fill color
    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
    
    // Draw a rectangle
    CGRect rectangle = CGRectMake(50, 50, 200, 100);
    CGContextAddRect(context, rectangle);
    CGContextFillPath(context);
    
    // Set the stroke color
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextSetLineWidth(context, 5.0);
    
    // Draw a circle
    CGRect circle = CGRectMake(150, 200, 100, 100);
    CGContextAddEllipseInRect(context, circle);
    CGContextStrokePath(context);
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isSwiping = NO;
    UITouch *touch = [touches anyObject];
    self.lastPoint = [touch locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.isSwiping = YES;
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    
    UIGraphicsBeginImageContext(self.frame.size);
    [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.lastPoint = currentPoint;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!self.isSwiping) {
        UIGraphicsBeginImageContext(self.frame.size);
        [self.image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 5.0);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor blackColor].CGColor);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), self.lastPoint.x, self.lastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        self.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    [self setNeedsDisplay];
}

@end
