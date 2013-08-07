//
//  JAGrid.m
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-08-07.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "JAGrid.h"

@implementation JAGrid

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if(self)
    {
        wasDrawn = FALSE;
        [self createScene];
        [self createSpawners];
    }
    return self;
}

#pragma mark - Create scene
- (void)createScene
{
    self.backgroundColor = [SKColor greenColor];
    self.scaleMode = SKSceneScaleModeAspectFill;
}

#pragma mark - Create spawners
- (void)createSpawners
{
    SKAction *spawnAction = [SKAction sequence:@[[SKAction performSelector:@selector(createEnemy) onTarget:self], [SKAction waitForDuration:0.25f withRange:0.5]]];
    [self runAction:[SKAction repeatActionForever:spawnAction]];
}

- (void)createEnemy
{
    if(!wasDrawn)
        return;
    
    SKSpriteNode *enemy = [[SKSpriteNode alloc] initWithColor:[SKColor whiteColor] size:CGSizeMake(20, 20)];
    enemy.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:enemy.size];
    enemy.position = CGPointZero;
    [self addChild:enemy];
    
    [enemy runAction:[self enemyAction]];
}

- (SKAction *)enemyAction
{
    CGPathRef path = [self createPath];
    SKAction *enemyAction = [SKAction followPath:path asOffset:FALSE orientToPath:TRUE duration:10];
    SKAction *removeAction = [SKAction removeFromParent];
    SKAction *sequence = [SKAction sequence:@[enemyAction, removeAction]];
    
    return sequence;
}

#pragma mark - Create path
- (CGPathRef)createPath
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    //Start somewhere
    [path moveToPoint:[pathPoints[0] CGPointValue]];
    
    for(NSUInteger i = 1; i < pathPoints.count; i++)
    {
        [path addLineToPoint:[pathPoints[i] CGPointValue]];
    }
    
    return path.CGPath;
}

#pragma mark - Draw path
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(wasDrawn) return;
    
    if(!pathPoints)
        pathPoints = [NSMutableArray new];
    
    [pathPoints removeAllObjects];
    
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(wasDrawn) return;

    CGPoint touchLocation = [[touches anyObject] locationInView:self.view];
    
    [pathPoints addObject:[NSValue valueWithCGPoint:touchLocation]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(wasDrawn) return;

    wasDrawn = TRUE;
    [self createRandomThing];
}

#pragma mark - Create random thing that flies through things
- (void)createRandomThing
{
    SKSpriteNode *randomThing = [[SKSpriteNode alloc] initWithColor:[SKColor darkGrayColor] size:CGSizeMake(50, 50)];
    randomThing.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:randomThing.size];
    randomThing.position = CGPointMake(self.size.width / 2, 0);
    randomThing.physicsBody.restitution = 0.0f;
    randomThing.physicsBody.friction = 1.0f;
    randomThing.physicsBody.density = 1000.0f;
    [self addChild:randomThing];
    
    //Action
    SKAction *action = [SKAction sequence:@[[SKAction moveTo:CGPointMake(self.size.width / 2, self.size.height) duration:20], [SKAction removeFromParent]]];
    
    [randomThing runAction:action];
}

@end
