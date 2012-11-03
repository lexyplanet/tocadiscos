//
//  BotonesRetro.h
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BotonesRetro : NSObject
{
    NSString *nombreBotonPlay;
    NSString *nombreBotonPause;
    NSString *nombreBotonStop;
}

- (void) apagarPlay: (UIButton*)playButton;

- (void) apagarPause: (UIButton*)pauseButton;

- (void) apagarStop: (UIButton*)stopButton;

- (void) encenderPlay: (UIButton*)playButton;

- (void) encenderPause: (UIButton*)pauseButton;

- (void) encenderStop: (UIButton*)stopButton;

@end
