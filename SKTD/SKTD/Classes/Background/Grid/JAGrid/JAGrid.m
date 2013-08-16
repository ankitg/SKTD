//
//  JAGrid.m
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-08-07.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "JAGrid.h"
#import "JAGridPeice.h"

#define tileSize    \
    CGSizeMake([UIScreen mainScreen].bounds.size.width / kGridColumns, [UIScreen mainScreen].bounds.size.height / kGridRows)

NS_ENUM(NSUInteger, JAGridTileZIndex)
{
    kJAGridTileZIndexBottom,
    kJAGridTileZIndexTop
};

@implementation JAGrid

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if(self)
    {
        [self createScene];
        [self createGrid];
        [self updateGridPeices];
    }
    return self;
}

#pragma mark - Create scene
- (void)createScene
{
    self.scaleMode = SKSceneScaleModeAspectFill;
}

#pragma mark - Create grid
- (void)createGrid
{
    gridPeices = [[NSMutableArray alloc] initWithCapacity:kGridRows * kGridColumns];
    
    NSUInteger currentColumn = 0;
    NSUInteger currentRow = 0;
    
    CGFloat startingPos = 32.0f;
    CGFloat xPos = startingPos;
    CGFloat yPos = 0.0f;
    
    for(; currentRow < kGridRows; currentRow++)
    {
        for(currentColumn = 0; currentColumn < kGridColumns; currentColumn++)
        {
            JAGridPeice *gridPeice = [self createGridPeice];
            gridPeice.position = CGPointMake(xPos, yPos);
            
            [self addChild:gridPeice];
            [gridPeices addObject:gridPeice];
            
            xPos += tileSize.width;
        }
        
        xPos = startingPos;
        yPos += tileSize.height;
    }
}

- (JAGridPeice *)createGridPeice
{
    //TODO : Get some index
    NSUInteger index = 0;
    
    JAGridPeice *gridPeice = [JAGridPeice spriteNodeWithTexture:[self createGridPeiceTexture:index] size:tileSize];
    gridPeice.blendMode = SKBlendModeReplace;

    return gridPeice;
}

- (SKTexture *)createGridPeiceTexture:(NSUInteger)textIndex;
{
    SKTexture *texture = [SKTexture textureWithImageNamed:@"TileGrass0"];
    
    return texture;
}

#pragma mark - Update tiles
- (void)updateGridPeices
{
    for(JAGridPeice *peice in gridPeices)
    {
//        [peice updateImage:[UIImage imageNamed:@"grass20"]];
    }
}

#pragma mark - Tile touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(touches.count == 1)
    {
        CGPoint touchLocation = [[touches anyObject] locationInNode:self];
        
        currentTile = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
        currentTile.blendMode = SKBlendModeScreen;
        currentTile.zPosition = kJAGridTileZIndexTop;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint touchLocation = [[touches anyObject] locationInNode:self];
    
    currentTile.position = touchLocation;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesEnded:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(currentTile)
    {
        currentTile.blendMode = SKBlendModeReplace;
        currentTile.zPosition = kJAGridTileZIndexBottom;
        currentTile = nil;
    }
}

@end
