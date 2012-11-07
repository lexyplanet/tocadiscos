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
//#import "BotonesRetro.h"
#import "Boton.h"

@interface PlayerPicker : NSObject
{
    /*BotonesRetro *botonPlay;
    BotonesRetro *botonPause;
    BotonesRetro *botonStop;*/
}


@property (nonatomic, strong) AVAudioPlayer *reproductor;
@property(nonatomic, strong) NSString* cancionActual;

@property(nonatomic, strong) NSTimer *timer; //ADRIAN

- (void) iniciaReproductor: (Boton*)playButton
            andPauseButton: (Boton*)pauseButton
             andStopButton: (Boton*)stopButton;
-(void) playButton;
-(void) pauseButton;
-(void) stopButton;
-(void) volumen:(id)sender;
//-(NSString*) songTime;
//-(void) songCurrent: (UILabel*)tiempoQueTranscurre;

//- (void)updateProgressBar:(NSTimer *)timer tiempoQueTranscurre:(UILabel*)tiempoQueTranscurre;

@end
