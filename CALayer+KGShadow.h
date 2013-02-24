//
//  CALayer+KGShadow.h
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

#import <QuartzCore/QuartzCore.h>

@interface CALayer (KGShadow)

- (void)addShadowWithcolor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;
- (void)updateShadowPath;

- (void)removeShadow;
- (void)restoreShadow;

- (void)animateShadowFrom:(CGRect)fromValue to:(CGRect)toValue duration:(CGFloat)duration;

@end
