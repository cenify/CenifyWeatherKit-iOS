//
//  CENSunnyDayWeatherBackgroundView.m
//  CenifyWeatherKit
//
//  Created by Gregory Sapienza on 11/4/15.
//  Copyright © 2015 Cenify. All rights reserved.
//

#import "CENSunnyDayWeatherBackgroundView.h"

/*
 
 DO NOT USE!
 
 USE CENSunnyDayBackgroundView INSTEAD
 
 */

@interface SunnyDayWeatherBackgroundScene : SKScene

///Left most cloud
@property (nonatomic) SKSpriteNode *_cloud1;

///Right most cloud
@property (nonatomic) SKSpriteNode *_cloud2;

///Upper middle cloud
@property (nonatomic) SKSpriteNode *_cloud3;

@end

@implementation SunnyDayWeatherBackgroundScene

///Setup for scene
- (void)didMoveToView:(SKView *)view {
    [self setUpBackgroundImage];
    [self setUpClouds];
    [self setUpCloudAnimations];
}

- (void)setUpBackgroundImage {
    UIImage *backgroundImage = [UIImage imageNamed:@"SunnyDayBackground" inBundle:[NSBundle bundleForClass:[SunnyDayWeatherBackgroundScene class]] compatibleWithTraitCollection:nil];
    
    SKSpriteNode *backgroundNode = [[SKSpriteNode alloc] init];
    
    backgroundNode.texture = [SKTexture textureWithImage:backgroundImage];
    backgroundNode.position = CGPointMake(self.size.width/2, self.size.height/2);
    backgroundNode.size = self.size;
    [self addChild:backgroundNode];
}

///Places clouds on screen
- (void)setUpClouds {
    [self setUpCloud1];
    [self setUpCloud2];
    [self setUpCloud3];
}

///Sets up first left most cloud
- (void)setUpCloud1 {
    UIImage *cloudImage1 = [UIImage imageNamed:@"SunnyDayCloud1" inBundle:[NSBundle bundleForClass:[SunnyDayWeatherBackgroundScene class]] compatibleWithTraitCollection:nil];
    
    self._cloud1 = [[SKSpriteNode alloc] init];
    
    self._cloud1.texture = [SKTexture textureWithImage:cloudImage1];
    self._cloud1.position = CGPointMake(-self._cloud1.size.width / 2, self.size.height - 100);
    self._cloud1.size = CGSizeMake(300, 200);
    [self addChild:self._cloud1];
}

///Sets up right most cloud
- (void)setUpCloud2 {
    UIImage *cloudImage2 = [UIImage imageNamed:@"SunnyDayCloud2" inBundle:[NSBundle bundleForClass:[SunnyDayWeatherBackgroundScene class]] compatibleWithTraitCollection:nil];
    
    self._cloud2 = [[SKSpriteNode alloc] init];
    
    self._cloud2.texture = [SKTexture textureWithImage:cloudImage2];
    self._cloud2.position = CGPointMake(self.size.width + self._cloud2.size.width / 2, self.size.height - 200);
    self._cloud2.size = CGSizeMake(300, 180);
    [self addChild:self._cloud2];
}

///Sets up middle upper cloud
- (void)setUpCloud3 {
    UIImage *cloudImage3 = [UIImage imageNamed:@"SunnyDayCloud3" inBundle:[NSBundle bundleForClass:[SunnyDayWeatherBackgroundScene class]] compatibleWithTraitCollection:nil];
    
    self._cloud3 = [[SKSpriteNode alloc] init];
    
    self._cloud3.texture = [SKTexture textureWithImage:cloudImage3];
    self._cloud3.position = CGPointMake(self.size.width / 2 + self._cloud3.size.width / 2, self.size.height - 50);
    self._cloud3.size = CGSizeMake(300, 160);
    [self addChild:self._cloud3];
}

///Launches cloud animations
- (void)setUpCloudAnimations {
    [self setUpCloudAnimation1];
    [self setUpCloudAnimation2];
    [self setUpCloudAnimation3];
}


///Sets up cloud 1 animation
///Resets cloud to starting point, moves it to the other end, then restarts the animation
- (void)setUpCloudAnimation1 {
    SKAction *cloudResetAction = [SKAction moveToX:-self._cloud1.size.width / 2 duration:0];
    SKAction *cloudMoveAction = [SKAction moveToX:self.size.width + self._cloud1.size.width duration:60];
    NSArray *actions = @[cloudResetAction, cloudMoveAction];
    SKAction *restartAnimation = [SKAction repeatActionForever:[SKAction sequence:actions]];
    [self._cloud1 runAction:restartAnimation];
}

///Sets up cloud 1 animation
///Resets cloud to starting point, moves it to the other end, then restarts the animation
- (void)setUpCloudAnimation2 {
    SKAction *cloudResetAction = [SKAction moveToX:self.size.width + self._cloud2.size.width / 2 duration:0];
    SKAction *cloudMoveAction = [SKAction moveToX:-self._cloud2.size.width / 2 duration:50];
    NSArray *actions = @[cloudResetAction, cloudMoveAction];
    SKAction *restartAnimation = [SKAction repeatActionForever:[SKAction sequence:actions]];
    [self._cloud2 runAction:restartAnimation];
}

///Sets up cloud 3 animation
///Moves it from middle to right most end, resets it on the left most end, then restarts the animation
- (void)setUpCloudAnimation3 {
    SKAction *cloudResetAction = [SKAction moveToX:-self._cloud3.size.width / 2 duration:0];
    SKAction *cloudMoveAction = [SKAction moveToX:self.size.width + self._cloud3.size.width duration:80];
    NSArray *actions = @[cloudMoveAction, cloudResetAction];
    SKAction *restartAnimation = [SKAction repeatActionForever:[SKAction sequence:actions]];
    [self._cloud3 runAction:restartAnimation];
}

@end

@implementation CENSunnyDayWeatherBackgroundView

///Lays out main scene
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    SunnyDayWeatherBackgroundScene *scene = [[SunnyDayWeatherBackgroundScene alloc] initWithSize:self.bounds.size];
    SKView *sceneView = [[SKView alloc] initWithFrame:self.bounds];
    sceneView.frameInterval = 3;
    sceneView.asynchronous = true;
    sceneView.shouldCullNonVisibleNodes = false;
    sceneView.showsFPS = YES;
    sceneView.showsNodeCount = YES;
    sceneView.ignoresSiblingOrder = YES;
    [self addSubview:sceneView];
    
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [sceneView presentScene:scene];
}

@end
