//
//  GameScene.m
//  Bezier Rider
//
//  Created by Justin Yu on 5/12/15.
//  Copyright (c) 2015 Justin Yu. All rights reserved.
//

#import "GameScene.h"

#import "JYPoint.h"
#import "JYBall.h"
#import "JYUtils.h"
#import "JYTarget.h"
#import "SKBezierNode.h"
#import "JYStageButton.h"
#import "JYHighlightNode.h"
#import "JYTutorialLabel.h"
#import "JYWall.h"
#import "SKButton.h"

@interface GameScene ()

@property (nonatomic, strong) NSMutableArray *curves;

@property (nonatomic, strong) JYBall *ball;
@property (nonatomic, strong) JYTarget *target;
@property (nonatomic) BOOL adding;
@property (nonatomic) BOOL running;
@property (nonatomic) BOOL won;
@property (nonatomic) NSInteger stage;

@property (nonatomic, strong) SKButton *backButton;
@property (nonatomic, strong) SKButton *addButton;
@property (nonatomic, strong) SKButton *replayButton;
@property (nonatomic, strong) SKButton *playButton;
@property (nonatomic, strong) SKButton *doneButton;

@property (nonatomic, strong) JYHighlightNode *highlight;
@property (nonatomic) NSInteger tutorialStep; // starts at 1, progresses as you progress forward through the tutorial

@property (nonatomic, strong) SKLabelNode *winLabel;

@end

@implementation GameScene

#pragma mark - Init

- (instancetype)initWithSize:(CGSize)size stage:(NSInteger)stage {
    
    if (self = [super initWithSize:size]) {
        
        self.stage = stage;
        //        NSLog(@"Stage : %d", (int)_stage);
    }
    
    return self;
}

- (void)setupGameplayButtons {
    
    CGSize buttonSize = CGSizeMake(40., 40.);
    CGFloat padding = 10;
    
    _backButton = [[SKButton alloc] initWithPosition:CGPointMake(buttonSize.width / 2 + padding, HEIGHT(self.view) - buttonSize.height / 2 - padding) size:buttonSize];
    [self addChild:_backButton];
    _backButton.name = @"back";
    _backButton.image = [UIImage imageNamed:@"back"];
//    backButton.text = @"◀︎";
    
    _addButton = [[SKButton alloc] initWithPosition:CGPointMake(buttonSize.width / 2 + padding, buttonSize.height / 2 + padding) size:buttonSize];
    [self addChild:_addButton];
    _addButton.name = @"add";
    _addButton.image = [UIImage imageNamed:@"plus"];
//    addButton.text = @"+";
    
    _playButton = [[SKButton alloc] initWithPosition:CGPointMake(1.5 * buttonSize.width + 2 * padding, buttonSize.height / 2 + padding) size:buttonSize];
    [self addChild:_playButton];
    _playButton.name = @"play";
    _playButton.image = [UIImage imageNamed:@"play"];
//    playButton.text = @"▶︎";
    
    _replayButton = [[SKButton alloc] initWithPosition:CGPointMake(2.5 * buttonSize.width + 3 * padding, buttonSize.height / 2 + padding) size:buttonSize];
    [self addChild:_replayButton];
    _replayButton.name = @"replay";
    _replayButton.image = [UIImage imageNamed:@"replay"];
    
    _replayButton.enabled = NO;
    
    _doneButton = [[SKButton alloc] initWithPosition:CGPointMake(WIDTH(self.view) - padding - 80. / 2, HEIGHT(self.view) - padding - buttonSize.height / 2) size:CGSizeMake(80., buttonSize.height)];
    _doneButton.name = @"done";
    _doneButton.text = @"Done";
    [self addChild:_doneButton];
    _doneButton.hidden = YES;
}

- (void)didMoveToView:(SKView *)view {
    
    [self setupGameplayButtons];
    self.backgroundColor = [UIColor wetAsphaltColor];
    self.physicsWorld.contactDelegate = self;
    
    [UIView animateWithDuration:2.0f animations:^{
        self.backgroundColor = [UIColor cloudsColor];
    }];
    
    _curves = [[NSMutableArray alloc] init];
    _running = NO;
    
    [self setupSceneForStage:_stage];
}

#pragma mark - Setting Up Stages

- (void)setupSceneForStage:(NSInteger)stage {
    
    switch (stage) {
        case 0:
            [self setupTutorialStage];
            break;
        case 3:
            [self setupStageThree];
            break;
    }
}

- (void)setupTutorialStage {
    
    _ball = [[JYBall alloc] initWithColor:[UIColor alizarinColor] position:CGPointMake(100, HEIGHT(self.view) - 80.0f) size:CGSizeMake(50., 50.)];

    SKTexture *targetTexture = [SKTexture textureWithImageNamed:@"target"];
    _target = [[JYTarget alloc] initWithTexture:targetTexture color:[UIColor clearColor] size:CGSizeMake(40., 40.)];
    _target.position = CGPointMake(WIDTH(self.view) - 100, 150);

    if (_tutorialStep < 4) {
        JYTutorialLabel *tutorialLabel = [[JYTutorialLabel alloc] init];
        tutorialLabel.text = @"Click the highlighted button to add a curve.";
        tutorialLabel.position = CGPointMake(_addButton.position.x - _addButton.frame.size.width / 2, _addButton.position.y + 30.);
        
        JYTutorialLabel *ballLabel = [[JYTutorialLabel alloc] init];
        ballLabel.text = @"This ball will interact with your curves.";
        
        _tutorialStep = 1;
        [self addChild:tutorialLabel];
        
        JYHighlightNode *highlight = [[JYHighlightNode alloc] initWithPosition:_addButton.position size:CGSizeMake(_addButton.frame.size.width + 5., _addButton.frame.size.height + 5.)];
        [self addChild:highlight];
        _highlight = highlight;

    }

    [self addChild:_ball];
    
    if (_tutorialStep == 4) {
        [self addChild:_target];
        _target.alpha = 0;
        [_target runAction:[SKAction fadeInWithDuration:1.0f]];
        
        JYTutorialLabel *targetLabel = [[JYTutorialLabel alloc] init];
        targetLabel.text = @"Use the Beziér Curves to get your ball into this target.";
        targetLabel.position = CGPointMake(WIDTH(self.view) - _doneButton.frame.size.width - 5, HEIGHT(self.view) - 35);
        targetLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        [self addChild:targetLabel];
    }
}

- (void)setupStageOne {
    
    
}

- (void)setupStageThree {
    
    _ball = [[JYBall alloc] initWithColor:[UIColor alizarinColor] position:CGPointMake(100, HEIGHT(self.view) - 70.) size:CGSizeMake(40., 40.)];
    
    SKTexture *targetTexture = [SKTexture textureWithImageNamed:@"target"];
    _target = [[JYTarget alloc] initWithTexture:targetTexture color:[UIColor clearColor] size:CGSizeMake(40, 40)];
    _target.position = CGPointMake(WIDTH(self.view) - 100, 100.);
    
    [self addChild:_ball];
    [self addChild:_target];
    
    // Walls
    JYWall *wall1 = [[JYWall alloc] initWithPoint:CGPointMake(WIDTH(self.view) / 3, 0) andEndpoint:CGPointMake(WIDTH(self.view) / 3, 2 * HEIGHT(self.view) / 3)];
    [self addChild:wall1];
    JYWall *wall2 = [[JYWall alloc] initWithPoint:CGPointMake(2 * WIDTH(self.view) / 3, HEIGHT(self.view)) andEndpoint:CGPointMake(2 * WIDTH(self.view) / 3, HEIGHT(self.view) / 3)];
    [self addChild:wall2];
}

#pragma mark - Bezier Curves

- (void)drawBezierCurves {
    
    for (id object in _curves) {
        
        if ([object isKindOfClass:[NSMutableArray class]]) {
            
            NSMutableArray *array = (NSMutableArray *)object;
            
            if ([array count] >= 3) {
                
                JYPoint *colorPoint = (JYPoint *)array[0];
                
                SKBezierNode *bezier = [[SKBezierNode alloc] initWithPoints:array color:colorPoint.strokeColor];
                [self addChild:bezier];
            }
        }
    }
}

- (void)addSegmentBetween:(JYPoint *)p0 andEndpoint:(JYPoint *)p1 {
    
    SKShapeNode *line = [[SKShapeNode alloc] init];
    CGMutablePathRef linePath = CGPathCreateMutable();
    
    CGPathMoveToPoint(linePath, NULL, p0.x, p0.y);
    CGPathAddLineToPoint(linePath, NULL, p1.x, p1.y);

    CGFloat pattern[2];
    pattern[0] = 10.0;
    pattern[1] = 10.0;
    CGPathRef dashedLine = CGPathCreateCopyByDashingPath(linePath, NULL, 0., pattern, 2);
    
    line.path = dashedLine;
    line.lineWidth = 2.0f;
    line.lineCap = 1.0f;
    
    line.strokeColor = p0.strokeColor;
    
    [self addChild:line];
}

#pragma mark - Handling Touches

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:touchPoint];
    
//    CGPoint scenePoint = [self convertPointFromView:touchPoint];
//    NSLog(@"%f, %f", scenePoint.x, scenePoint.y);
    
    if ([node.name isEqualToString:@"done"] ||
        [node isKindOfClass:[SKButton class]] ||
        [node isKindOfClass:[JYPoint class]] ||
        [node isKindOfClass:[SKSpriteNode class]] ||
        [node isKindOfClass:[SKLabelNode class]]) {
        
        if ([node.name isEqualToString:@"back"]) {
            
            [self.delegate didHitBackButton];
        } else if ([node.name isEqualToString:@"play"] && !_running && !_adding) {
            
            if (_tutorialStep == 3) {
                
                [self removeChildrenWithName:@"highlight"];
                [self removeChildrenWithName:@"tutorial"];
                
                JYTutorialLabel *clearLabel = [[JYTutorialLabel alloc] init];
                clearLabel.text = @"Reset your field once you're done.";
                clearLabel.position = CGPointMake(_replayButton.position.x + _replayButton.frame.size.width / 2 + 10, _replayButton.frame.size.height / 2);
                [self addChild:clearLabel];
                
                _highlight = [[JYHighlightNode alloc] initWithPosition:_replayButton.position size:CGSizeMake(_addButton.frame.size.width + 5., _addButton.frame.size.height + 5.)];
                [self addChild:_highlight];
                
                _tutorialStep++;
            }
            
            _running = YES;
            _addButton.enabled = NO;
            _replayButton.enabled = YES;
            
            _ball.physicsBody.affectedByGravity = YES;
            
            [self drawBezierCurves];
        } else if ([node.name isEqualToString:@"add"] && !_running) {
            
            if (_tutorialStep == 1) {
                
                [self removeChildrenWithName:@"highlight"];
                [self removeChildrenWithName:@"tutorial"];
                JYTutorialLabel *tutorialLabel = [[JYTutorialLabel alloc] init];
                tutorialLabel.text = @"Tap on the white space to create a point.";
                tutorialLabel.position = CGPointMake(_addButton.position.x - _addButton.frame.size.width / 2, _addButton.position.y + 60);
                
                JYTutorialLabel *aTutorialLabel = [[JYTutorialLabel alloc] init];
                aTutorialLabel.text = @"You need 3-4 points to create a curve.";
                aTutorialLabel.position = CGPointMake(_addButton.position.x - _addButton.frame.size.width / 2, _addButton.position.y + 30);
                
                JYTutorialLabel *bTutorialLabel = [[JYTutorialLabel alloc] init];
                bTutorialLabel.text = @"After you plot your points, hit done.";
                bTutorialLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
                
                [self addChild:tutorialLabel];
                [self addChild:aTutorialLabel];
                [self addChild:bTutorialLabel];
                
                _highlight = [[JYHighlightNode alloc] initWithPosition:_doneButton.position size:CGSizeMake(_addButton.frame.size.width + 5., _addButton.frame.size.height + 5.)];
                [self addChild:_highlight];
                
                bTutorialLabel.position = CGPointMake(WIDTH(self.view) - _doneButton.frame.size.width - 20, HEIGHT(self.view) - 35);
                _tutorialStep++;
            }
            
            _doneButton.hidden = NO;
            _adding = YES;
            
            _addButton.enabled = NO;
            _replayButton.enabled = NO;
            _playButton.enabled = NO;
                        
            if ([_curves count] == 0) {
                
                NSMutableArray *newArray = [[NSMutableArray alloc] init];
                [_curves addObject:newArray];
            } else if ([_curves count] <= 6) { // MAX of 6 curves

                NSMutableArray *array = (NSMutableArray *)(_curves[[_curves count] - 1]);

                if ([array count] == 3 || [array count] == 4) {
                    
                    NSMutableArray *newArray = [[NSMutableArray alloc] init];
                    [_curves addObject:newArray];
                    
                    NSLog(@"Adding a new curve: %d", (int)[_curves count]);
                }
            }
            
        } else if ([node.name isEqualToString:@"replay"] && !_adding) {

            [self removeAllChildren];
            
            _running = NO;
            _curves = nil;
            _curves = [[NSMutableArray alloc] init];
            
            _adding = NO;
            
            _addButton.enabled = YES;
            
            [self setupGameplayButtons];
            [self setupSceneForStage:_stage];
        } else if ([node.name isEqualToString:@"done"]) {
            
            if ([(NSMutableArray *)[_curves lastObject] count] == 0 || ([(NSMutableArray *)[_curves lastObject] count] >= 3 && [(NSMutableArray *)[_curves lastObject] count] < 5)) {
                
                _adding = NO;
                
                _addButton.enabled = YES;
                _replayButton.enabled = YES;
                _playButton.enabled = YES;
                
                _doneButton.hidden = YES;
                
                if (_tutorialStep == 2) {
                    
                    [self removeChildrenWithName:@"highlight"];
                    [self removeChildrenWithName:@"tutorial"];
                    
                    JYTutorialLabel *tutorialLabel = [[JYTutorialLabel alloc] init];
                    tutorialLabel.text = @"Hit the play button to test your Beziér curve.";
                    tutorialLabel.position = CGPointMake(_addButton.position.x - _addButton.frame.size.width / 2, _addButton.position.y + 30);
                    [self addChild:tutorialLabel];
                    
                    _highlight = [[JYHighlightNode alloc] initWithPosition:_playButton.position size:CGSizeMake(_addButton.frame.size.width + 5., _addButton.frame.size.height + 5.)];
                    [self addChild:_highlight];
                    
                    _tutorialStep++;
                }
            }
            
        }
    } else if (_adding && ![node isKindOfClass:[JYPoint class]]) {
        
        if ([_curves[[_curves count] - 1] isKindOfClass:[NSMutableArray class]]) {
            
            NSMutableArray *array = (NSMutableArray *)(_curves[[_curves count] - 1]);
            if ([array count] == 4) {

                
                NSLog(@"Full, add a new curve");
            } else if ([_curves count] <= 6) {
                NSMutableArray *array = ((NSMutableArray *)_curves[[_curves count] - 1]);
                
                UIColor *color = (UIColor *)([JYUtils colorArray][[_curves count] - 1]);
                JYPoint *point = [[JYPoint alloc] initWithSize:CGSizeMake(10.0, 10.0) atPosition:touchPoint color:color];
                [self addChild:point];
                [array addObject:point];
                                
                if ([array count] >= 2) {
                    [self addSegmentBetween:(JYPoint *)array[[array count] - 2] andEndpoint:point];
                }
                
                if ([array count] == 4) {
                    
                    if (_tutorialStep == 2) {
                        [self removeChildrenWithName:@"highlight"];
                        [self removeChildrenWithName:@"tutorial"];
                        
                        JYTutorialLabel *tutorialLabel = [[JYTutorialLabel alloc] init];
                        tutorialLabel.text = @"Hit the play button to test your Beziér curve.";
                        tutorialLabel.position = CGPointMake(_addButton.position.x - _addButton.frame.size.width / 2, _addButton.position.y + 30);
                        [self addChild:tutorialLabel];
                        
                        _highlight = [[JYHighlightNode alloc] initWithPosition:_playButton.position size:CGSizeMake(_addButton.frame.size.width + 5., _addButton.frame.size.height + 5.)];
                        [self addChild:_highlight];
                        
                        _tutorialStep++;
                    }
                    
                    // Same as done
                    _adding = NO;
                    
                    _addButton.enabled = YES;
                    _replayButton.enabled = YES;
                    _playButton.enabled = YES;
                    
                    _doneButton.hidden = YES;
                }
                
            }
        }
    }
}

- (void)removeChildrenWithName:(NSString *)name {
    
    for (id object in self.children) {
        
        if ([object isKindOfClass:[SKNode class]]) {
            SKNode *node = (SKNode *)object;
            if ([node.name isEqualToString:name]) {
                [node removeFromParent];
            }
        }
    }
}

#pragma mark - Contact Delegate / Winning

- (void)didBeginContact:(SKPhysicsContact *)contact {
    
    if ((contact.bodyA.categoryBitMask == ballCategory && contact.bodyB.categoryBitMask == targetCategory) ||
        (contact.bodyA.categoryBitMask == targetCategory && contact.bodyB.categoryBitMask == ballCategory)) {
        
            
        SKAction *fade = [SKAction fadeOutWithDuration:1.0f];
        _ball.physicsBody.affectedByGravity = NO;
        _ball.physicsBody.velocity = CGVectorMake(_ball.physicsBody.velocity.dx / 3, _ball.physicsBody.velocity.dy / 3);
        [_ball runAction:fade];
        
        [self displayWinScreen];
    }
}

- (void)displayWinScreen {
    
    for (id object in self.children) {
        
        SKAction *fade = [SKAction fadeOutWithDuration:1.0f];
        SKAction *showWinOverlay = [SKAction performSelector:@selector(showWinOverlay) onTarget:self];
        
        if ([object isKindOfClass:[SKNode class]]) {
            [(SKNode *)object runAction:[SKAction sequence:@[[SKAction waitForDuration:1.0f], fade, showWinOverlay]]];
        }
    }
    
}

- (void)showWinOverlay {
    
    if (!_winLabel) {
        self.anchorPoint = CGPointMake(0.5f, 0.5f);
        SKLabelNode *winLabel = [SKLabelNode labelNodeWithText:@"CONGRATULATIONS!"];
        _winLabel = winLabel;
        NSString *labelText = [NSString stringWithFormat:@"You beat stage %d!", (int)self.stage];
        
        if (self.stage == 0) {
            labelText = @"You beat the tutorial stage!";
        }
        
        SKLabelNode *descLabel = [SKLabelNode labelNodeWithText:labelText];
        
        winLabel.fontName = @"HelveticaNeue-Bold";
        winLabel.fontColor = [UIColor wetAsphaltColor];
        descLabel.fontColor = [UIColor wetAsphaltColor];
        winLabel.position = CGPointMake(0, 50);
        descLabel.position = CGPointMake(0, 0);
        
        [self addChild:winLabel];
        [self addChild:descLabel];
        
        SKButton *backButton = [[SKButton alloc] initWithPosition:CGPointMake(0, -50) size:CGSizeMake(80., 40.)];
        backButton.name = @"back";
        backButton.text = @"BACK";
        backButton.textLabel.fontColor = [UIColor whiteColor];
        [self addChild:backButton];
    }
}

@end
