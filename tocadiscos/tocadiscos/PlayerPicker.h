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

@property(nonatomic, strong) NSTimer *timer; //ADRIAN

-(void) playButton;
-(void) pauseButton;

-(void) stopButton;
-(void) nextButton:(id)sender;
-(void) forwardButton:(id)sender;
-(void) volumen:(id)sender;
-(void) songCurrent: (UILabel*) tiempoQueTranscurre;
-(NSString*) songTime;

@end
