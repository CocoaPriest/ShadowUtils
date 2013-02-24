//
//  CALayer+KGShadow.m
//
// _______ ______        _____               ________                      ______  
// ___    |___  /__________  /______ ___________  __/______ ____  ____________  /_ 
// __  /| |__  / __  ___/_  __/_  _ \__  ___/__  /   _  __ \_  / / /_  ___/__  __ \
// _  ___ |_  /  _(__  ) / /_  /  __/_  /    _  /    / /_/ // /_/ / / /__  _  / / /
// /_/  |_|/_/   /____/  \__/  \___/ /_/     /_/     \____/ \__,_/  \___/  /_/ /_/ 
//
//  Created by Konstantin Gonikman on 08.07.12.
//  Copyright (c) 2012 Alstertouch. All rights reserved.
//

#import "CALayer+ATShadow.h"
#import <objc/runtime.h>

@implementation CALayer (KGShadow)

static char COLOR_KEY;
static char OPACITY_KEY;

- (void)addShadowWithcolor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity {
	CGMutablePathRef shadowPath = CGPathCreateMutable();
	CGPathAddRect(shadowPath, NULL, [self bounds]);
	
	[self setShadowColor:color.CGColor];
	[self setShadowOffset:offset];
	[self setShadowRadius:radius];
	[self setShadowOpacity:opacity];
	[self setShadowPath:shadowPath];
	
	CFRelease(shadowPath);
	
	objc_setAssociatedObject(self, &COLOR_KEY, color, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	objc_setAssociatedObject(self, &OPACITY_KEY, @(opacity), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)updateShadowPath {
	CGMutablePathRef shadowPath = CGPathCreateMutable();
	CGPathAddRect(shadowPath, NULL, [self bounds]);
	[self setShadowPath:shadowPath];
	CFRelease(shadowPath);
}

- (void)removeShadow {
	[self setShadowColor:0];
	[self setShadowOpacity:0];
	[self setShadowPath:NULL];
}

- (void)restoreShadow {
	
	CGMutablePathRef shadowPath = CGPathCreateMutable();
	CGPathAddRect(shadowPath, NULL, [self bounds]);
	
	UIColor *lastUsedColor = objc_getAssociatedObject(self, &COLOR_KEY);
	CGFloat lastUsedOpacity = [(NSNumber *)objc_getAssociatedObject(self, &OPACITY_KEY) floatValue]; 
	
	[self setShadowColor:lastUsedColor.CGColor];
	[self setShadowOpacity:lastUsedOpacity];
	[self setShadowPath:shadowPath];
	CFRelease(shadowPath);
}

- (void)animateShadowFrom:(CGRect)fromValue to:(CGRect)toValue duration:(CGFloat)duration {

	CGMutablePathRef oldShadowPath = CGPathCreateMutable();
	CGPathAddRect(oldShadowPath, NULL/*transform*/, fromValue);	
	
	CGMutablePathRef newShadowPath = CGPathCreateMutable();
	CGPathAddRect(newShadowPath, NULL/*transform*/, toValue);
	
	CABasicAnimation *shadowAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
	
	shadowAnimation.fromValue = (__bridge id)oldShadowPath;	
	shadowAnimation.toValue = (__bridge id)newShadowPath;
	
	CFRelease(oldShadowPath);

	shadowAnimation.duration = duration;
	shadowAnimation.autoreverses = NO;
	shadowAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
	shadowAnimation.removedOnCompletion = NO;
	shadowAnimation.fillMode = kCAFillModeForwards;
	
	[self setValue:(__bridge id)newShadowPath forKeyPath:@"shadowPath"];	
	[self addAnimation:shadowAnimation forKey:@"shadowPath"];
	
	CFRelease(newShadowPath);
}

@end
