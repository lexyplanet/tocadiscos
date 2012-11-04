//
//  PlayerPicker.h
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "BotonesRetro.h"

@interface PlayerPicker : NSObject
{
    BotonesRetro *botonPlay;
    BotonesRetro *botonPause;
    BotonesRetro *botonStop;
}


@property (nonatomic, strong) AVAudioPlayer *reproductor;
@property(nonatomic, strong) NSString* cancionActual;

- (void) iniciaReproductor: (UIButton*)nuevoPlayButton
            andPauseButton: (UIButton*)nuevoPauseButton
             andStopButton: (UIButton*)nuevoStopButton;

- (void) playReproductor;

@end
