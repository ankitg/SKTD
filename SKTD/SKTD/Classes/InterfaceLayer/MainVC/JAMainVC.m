//
//  JAMainVC.m
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-08-22.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "JAControlsVC.h"
#import "JAMainVC.h"

@interface JAMainVC ()

@property (nonatomic, strong) JAControlsVC *controlsVC;

@end

@implementation JAMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create Controls
    [self createControls];
}

#pragma mark - Create controls
- (void)createControls
{
    _controlsVC = [[JAControlsVC alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:_controlsVC.view];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
