//
//  GameScene.h
//  Bezier Rider
//

//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <FlatUIKit/FlatUIKit.h>

@protocol GameSceneDelegate <NSObject>

@optional
- (void)didHitBackButton;

@end

@interface GameScene : SKScene <SKPhysicsContactDelegate>

- (instancetype)initWithSize:(CGSize)size stage:(NSInteger)stage;

@property (nonatomic, strong) id<GameSceneDelegate> delegate;

@end
