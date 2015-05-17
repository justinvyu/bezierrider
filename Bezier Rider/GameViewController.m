//
//  GameViewController.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/12/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "GameViewController.h"
#import "JYUtils.h"

@interface GameViewController ()

@property (nonatomic) NSInteger stage;

@end

@implementation GameViewController

- (void)loadView {
    
    self.view = [[SKView alloc] init];
}

- (instancetype)initWithStage:(NSInteger)stage {
    
    if (self = [super init]) {
        
        _stage = stage;
    }
    
    return self;
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    /* Sprite Kit applies additional optimizations to improve rendering performance */
    
    GameScene *scene = [[GameScene alloc] initWithSize:skView.bounds.size stage:_stage];
    scene.alpha = 0;
    [UIView animateWithDuration:1.0f animations:^{
        scene.alpha = 1;
    }];
    scene.delegate = self;
    // Present the scene.
    [skView presentScene:scene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (void)didHitBackButton {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
