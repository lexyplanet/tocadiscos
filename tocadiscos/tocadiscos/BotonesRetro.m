//
//  BotonesRetro.m
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "BotonesRetro.h"

@implementation BotonesRetro


- (void) apagarPlay: (UIButton*)playButton
{
    [playButton setImage:NO forState:UIControlStateNormal];
}

- (void) apagarPause: (UIButton*)pauseButton
{
    [pauseButton setImage:NO forState:UIControlStateNormal];
}

- (void) apagarStop: (UIButton*)stopButton
{
    [stopButton setImage:NO forState:UIControlStateNormal];
}

- (void) encenderPlay: (UIButton*)playButton
{
    [playButton setImage:[UIImage imageNamed:nombreBotonPlay] forState:UIControlStateNormal];
}

- (void) encenderPause: (UIButton*)pauseButton
{
    [pauseButton setImage:[UIImage imageNamed:nombreBotonPause] forState:UIControlStateNormal];
}

- (void) encenderStop: (UIButton*)stopButton
{
    [stopButton setImage:[UIImage imageNamed:nombreBotonStop] forState:UIControlStateNormal];
}

@end
