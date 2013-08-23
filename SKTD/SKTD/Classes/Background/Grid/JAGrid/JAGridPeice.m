//
//  JAGridPeice.m
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-08-15.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "JAGridPeice.h"

@implementation JAGridPeice
@synthesize isEmpty = _isEmpty;

- (id)initWithTexture:(SKTexture *)texture color:(UIColor *)color size:(CGSize)size
{
    self = [super initWithTexture:texture color:color size:size];
    if(self)
    {
        _isEmpty = TRUE;
    }
    return self;
}

#pragma mark - Empty handling
- (void)setIsEmpty:(BOOL)isEmpty
{
    _isEmpty = isEmpty;
    
    SKPhysicsBody *body = nil;
    
    if(isEmpty)
    {
        body = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
    }
    
    self.physicsBody = body;
}

- (BOOL)isEmpty
{
    return _isEmpty;
}

@end
