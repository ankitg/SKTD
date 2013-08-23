//
//  ViewController.m
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-07-31.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "JAGrid.h"
#import "JAMainVC.h"
#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Configure the view
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    //Create and configure the scene
    SKScene *scene = [JAGrid sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    //Present the scene
    [skView presentScene:scene];
    
    //Create main VC
    [self createMainVC];
}

- (void)createMainVC
{
    JAMainVC *mainVC = [[JAMainVC alloc] initWithNibName:nil bundle:nil];
    [self.view addSubview:mainVC.view];
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
