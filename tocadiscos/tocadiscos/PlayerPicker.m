//
//  PlayerPicker.m
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "PlayerPicker.h"

@implementation PlayerPicker

@synthesize reproductor;
@synthesize cancionActual;

- (void) iniciaReproductor: (UIButton*)nuevoPlayButton
            andPauseButton: (UIButton*)nuevoPauseButton
             andStopButton: (UIButton*)nuevoStopButton
{
    [botonPlay apagarPlay:nuevoPlayButton];
    [botonPause apagarPause:nuevoPauseButton];
    [botonStop apagarStop:nuevoStopButton];
    
    NSError * error;
    
    cancionActual = [[NSBundle mainBundle] pathForResource:@"dePeli" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:cancionActual];
    reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    
    reproductor.pan = 0;
    reproductor.volume = 0.5;
    
    reproductor.enableRate = YES;
    reproductor.rate = 1;
    
    [reproductor prepareToPlay];
    
    //Se oculta las imagenes asignadas a los botones del tocadiscos (play, pause, stop)
    /*[playButton setImage:NO forState:UIControlStateNormal];
    [pauseButton setImage:NO forState:UIControlStateNormal];
    [stopButton setImage:NO forState:UIControlStateNormal];*/
    
    
}

@end
