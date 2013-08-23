//
//  JAGridInterface.m
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-08-22.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "ControlsView.h"
#import "JAGridInterface.h"

@implementation JAGridInterface

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if(self)
    {
        [self createControls];
    }
    return self;
}

#pragma mark - Create controls
- (void)createControls
{
    controlView = ;
}

@end
