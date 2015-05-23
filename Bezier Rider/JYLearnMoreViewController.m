//
//  JYLearnMoreViewController.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/20/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "JYLearnMoreViewController.h"

#import <FlatUIKit/FlatUIKit.h>
#import <FLAnimatedImage/FLAnimatedImage.h>
#import "JYUtils.h"
#import "JYStageButton.h"

@interface JYLearnMoreViewController ()

@property (nonatomic, strong) FUIButton *backButton;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation JYLearnMoreViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:_scrollView];
    _scrollView.contentSize = CGSizeMake(WIDTH(self.view), HEIGHT(self.view) * 3);
    

    JYStageButton *backButton = [[JYStageButton alloc] initWithPosition:CGPointMake(5, 5) size:CGSizeMake(40., 40.) text:@"◀︎"];
    [self.view addSubview:backButton];
    [backButton addTarget:self action:@selector(dismissViewController) forControlEvents:UIControlEventTouchUpInside];
    _backButton = backButton;
    
    [self setupPageOne];
}

- (void)setupPageOne {
    
    FLAnimatedImage *gif = [FLAnimatedImage alloc] initWithAnimatedGIFData:NSData dataWithContentsOfURL:<#(NSURL *)#>
}

- (void)dismissViewController {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
