//
//  MyScene.m
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-07-31.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "MyScene.h"

@interface MyScene ()
{
    SKSpriteNode *_myShip;
    BOOL _isAnimating;
}

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        [self createShip];
        [self spawnStuff];
    }
    return self;
}

- (void)createShip
{
    _myShip = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
    
    CGFloat x = (self.frame.size.width) / 2 ;
    CGFloat y = (self.frame.size.height) / 2 ;
    
    _myShip.position = CGPointMake(x, y);
    [_myShip setScale:0.25];
    [self addChild:_myShip];
    
    //Ship collision
    [_myShip setPhysicsBody:[SKPhysicsBody bodyWithRectangleOfSize:_myShip.size]];
    _myShip.physicsBody.dynamic = FALSE;
}

#pragma mark - Spawn collision objects
- (void)spawnStuff
{
    SKAction *makeRocks = [SKAction sequence: @[[SKAction performSelector:@selector(addRock) onTarget:self],[SKAction waitForDuration:0.01 withRange:0.15]]];
    [self runAction: [SKAction repeatActionForever:makeRocks]];
}

- (void)addRock
{
    SKSpriteNode *rock = [[SKSpriteNode alloc] initWithColor:[SKColor brownColor] size:CGSizeMake(20, 20)];
    rock.position = CGPointMake(arc4random_uniform(1024), self.size.height - 50);
    rock.name = @"rock";
    rock.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection = YES;
    [self addChild:rock];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesMoved:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    if(_myShip)
    {
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            CGPoint currentLocation = _myShip.position;

            // Location
            SKAction *action = [SKAction moveTo:location duration:1.0f];
            [_myShip runAction:action];
            
            CGFloat duration = 0.35f;

            // Rotation
            CGPoint diff = CGPointMake((location.x - currentLocation.x), (location.y - currentLocation.y));
            CGFloat angle = -(atan2f(diff.x,diff.y));
            
            SKAction *actionAngle = [SKAction rotateToAngle:angle duration:0.15f shortestUnitArc:TRUE];
            [_myShip runAction:actionAngle];
            
            if(!_isAnimating)
            {
                _isAnimating = TRUE;
                //Flash red
                SKAction *action1 = [SKAction colorizeWithColor:[SKColor colorWithRed:1 green:0/255.0f blue:0/255.0f alpha:1.0f] colorBlendFactor:0.8f duration:duration];
                
                [_myShip runAction:[SKAction repeatAction:action1 count:4]];

                //Flash out red
                SKAction *action2 = [SKAction colorizeWithColor:[SKColor colorWithRed:1 green:0/255.0f blue:0/255.0f alpha:1.0f] colorBlendFactor:0.0f duration:duration];

                double delayInSeconds = duration / 2;
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [_myShip runAction:[SKAction repeatAction:action2 count:4] completion:^{
                        _isAnimating = FALSE;
                    }];

                });
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

-(void)didSimulatePhysics
{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop) {
        if (node.position.y < 0)
            [node removeFromParent];
    }];
}

@end
