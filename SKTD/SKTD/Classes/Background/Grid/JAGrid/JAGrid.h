//
//  JAGrid.h
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-08-07.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface JAGrid : SKScene
{
    @private
    //Tiles
    NSMutableArray *gridPeices;
    SKSpriteNode *currentTile;
}

//Place tile at point
- (void)placeTile:(SKNode *)tile atPointLocation:(CGPoint)locationPoint;

@end
