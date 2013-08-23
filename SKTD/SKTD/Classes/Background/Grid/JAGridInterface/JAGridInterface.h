//
//  JAGridInterface.h
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-08-22.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "JAGrid.h"

@class ControlsView;

@interface JAGridInterface : JAGrid

@property (nonatomic, strong, readonly) ControlsView *controlsView;

@end
