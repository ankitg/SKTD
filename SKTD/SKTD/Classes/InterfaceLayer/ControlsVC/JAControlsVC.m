//
//  JAControlsVC.m
//  SKTD
//
//  Created by Jeremy Fuellert on 2013-08-22.
//  Copyright (c) 2013 AFApps. All rights reserved.
//

#import "JAControls.h"
#import "JAControlsVC.h"

@interface JAControlsVC ()

@property (nonatomic, strong) JAControls *controls;

@end

@implementation JAControlsVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        [self createControls];
    }
    return self;
}

#pragma mark - Create controls
- (void)createControls
{
    _controls = [[JAControls alloc] initWithFrame:CGRectMake(0, self.view.frame.size.width - kControlsHeight, self.view.frame.size.height, kControlsHeight)];
    [self.view addSubview:_controls];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
