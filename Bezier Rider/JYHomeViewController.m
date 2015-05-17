//
//  JYHomeViewController.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/12/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYHomeViewController.h"

#import "JYUtils.h"
#import "GameViewController.h"
#import "JYStageButton.h"
#import "NSString+Icons.h"
#import "GameScene.h"

@interface JYHomeViewController ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *overlayView;
@property (nonatomic, strong) NSArray *colorArray;

@property (nonatomic, strong) FUIButton *playButton;
@property (nonatomic, strong) JYStageButton *backButton;

//@property (nonatomic, strong) SKView *skView;

@end

@implementation JYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _overlayView = [[UIView alloc] initWithFrame:FRAME(self.view)];
    _overlayView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_overlayView];
    
    [UIView animateWithDuration:FADE_DURATION animations:^{
        _overlayView.backgroundColor = [UIColor wetAsphaltColor];
    } completion:^(BOOL finished) {
        [self setupMenu];
    }];
    
//    _skView = [[SKView alloc] initWithFrame:self.view.frame];
//    [self.view addSubview:_skView];
//    _skView.hidden = YES;
}

- (void)setupMenu {
    
    for (id object in _overlayView.subviews) {
        if ([object isKindOfClass:[UIView class]]) {
            
            [JYUtils fadeOut:((UIView *)object) withDuration:FADE_DURATION completion:nil];
        }
    }
    
    FUIButton *playButton = [[FUIButton alloc] initWithFrame:CGRectMake(0, 0, 100., 40.)];
    playButton.center = self.view.center;
    
    playButton.buttonColor = [UIColor turquoiseColor];
    playButton.shadowColor = [UIColor greenSeaColor];
    playButton.shadowHeight = 3.0f;
    playButton.cornerRadius = 6.0f;
    playButton.titleLabel.font = [UIFont boldFlatFontOfSize:12];
    playButton.titleLabel.textColor = [UIColor whiteColor];
    [playButton setTitle:@"PLAY" forState:UIControlStateNormal];
    playButton.titleLabel.textAlignment = NSTextAlignmentCenter;
//    [playButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
//    [playButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    playButton.alpha = 0.0f;
    
    [playButton addTarget:self action:@selector(hidePlayButton) forControlEvents:UIControlEventTouchUpInside];
    
    _playButton = playButton;
    [_overlayView addSubview:playButton];
    
    JYStageButton *backButton = [[JYStageButton alloc] initWithPosition:CGPointMake(30, 30) size:CGSizeMake(40., 40.) text:@"◀︎"];
    [_overlayView addSubview:backButton];
    _backButton = backButton;
    [_backButton addTarget:self action:@selector(setupMenu) forControlEvents:UIControlEventTouchUpInside];
    
    _backButton.hidden = YES;
    
    [UIView animateWithDuration:1.0f animations:^{
        playButton.alpha = 1.0f;
    }];
}

- (void)hidePlayButton {
    
    [JYUtils fadeOut:_playButton withDuration:FADE_DURATION completion:^(BOOL completion) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.center.x - 100, self.view.center.y - 90, 200, 80)];
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setFont:[UIFont systemFontOfSize:20.0]];
        [titleLabel setText:@"STAGE SELECT"];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_overlayView addSubview:titleLabel];
        
        [JYUtils fadeInView:titleLabel withDuration:FADE_DURATION completion:^(BOOL finished) {
            [self showStageSelectMenu];
        }];
    }];
}

- (void)showStageSelectMenu {
    
    int padding = 10;
    CGSize buttonSize = CGSizeMake(40., 40.);
    
    JYStageButton *stageT = [[JYStageButton alloc] initWithPosition:CGPointMake(self.view.center.x - (2 * padding) - (2 * buttonSize.width),
                                                                                self.view.center.y) size:buttonSize text:@"T"];
    [_overlayView addSubview:stageT];
    stageT.stage = 0;
    [JYUtils fadeInView:stageT withDuration:FADE_DURATION completion:nil];
    [self addTargetToButton:stageT];

    JYStageButton *stage1 = [[JYStageButton alloc] initWithPosition:CGPointMake(self.view.center.x - padding - buttonSize.width,
                                                                                self.view.center.y) size:buttonSize text:@"1"];
    [_overlayView addSubview:stage1];
    stage1.stage = 1;
    [self addTargetToButton:stage1];
    [JYUtils fadeInView:stage1 withDuration:FADE_DURATION completion:nil];

    JYStageButton *stage2 = [[JYStageButton alloc] initWithPosition:self.view.center size:buttonSize text:@"2"];
    [_overlayView addSubview:stage2];
    stage2.stage = 2;
    [JYUtils fadeInView:stage2 withDuration:FADE_DURATION completion:nil];
    [self addTargetToButton:stage2];
    
    JYStageButton *stage3 = [[JYStageButton alloc] initWithPosition:CGPointMake(self.view.center.x + padding + buttonSize.width,
                                                                                self.view.center.y) size:buttonSize text:@"3"];
    [_overlayView addSubview:stage3];
    stage3.stage = 3;
    [JYUtils fadeInView:stage3 withDuration:FADE_DURATION completion:nil];
    [self addTargetToButton:stage3];
    JYStageButton *stage4 = [[JYStageButton alloc] initWithPosition:CGPointMake(self.view.center.x + (2 * padding) + (2 * buttonSize.width),
                                                                                self.view.center.y) size:buttonSize text:@"4"];
    [_overlayView addSubview:stage4];
    stage4.stage = 4;
    [self addTargetToButton:stage4];
    [JYUtils fadeInView:stage4 withDuration:FADE_DURATION completion:^(BOOL finished) {
        _backButton.hidden = NO;
        [JYUtils fadeInView:_backButton withDuration:FADE_DURATION completion:nil];
    }];
}

- (void)addTargetToButton:(JYStageButton *)button {
    
    [button addTarget:self action:@selector(presentGameSceneWithStage:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)presentGameSceneWithStage:(id)sender {
    
    if ([sender isKindOfClass:[JYStageButton class]]) {
        NSLog(@"%d", (int)((JYStageButton *)sender).stage);
        GameViewController *gameViewController = [[GameViewController alloc] initWithStage:((JYStageButton *)sender).stage];
        gameViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:gameViewController animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
