//
//  GameViewController.h
//  Bezier Rider
//

//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

#import "GameScene.h"

@interface GameViewController : UIViewController <GameSceneDelegate>

- (instancetype)initWithStage:(NSInteger)stage;

@end
