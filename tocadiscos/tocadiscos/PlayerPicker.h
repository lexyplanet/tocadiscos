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
#import "Boton.h"
#import "TocadiscosSlider.h"
#import "SeleccionAlertView.h"
#import "NuevaCancionViewController.h"

@interface PlayerPicker : NSObject
{
    NuevaCancionViewController *nuevaCancionlPicker;
    Boton *auxPlayButton;
}


@property (nonatomic, strong) AVAudioPlayer *reproductor;
@property(nonatomic, strong) NSString* cancionActual;

@property(nonatomic, strong) NSTimer *timer; //ADRIAN

- (void) iniciaReproductor: (Boton*)playButton
            andPauseButton: (Boton*)pauseButton
             andStopButton: (Boton*)stopButton
          andNombreCancion: (NSString*)cancion;

-(BOOL) verificaCancionActual;

-(void) playButton;
-(void) pauseButton;
-(void) stopButton;

-(void) volumen:(id)sender;
-(void) pan:(id)sender;
-(void) rate:(id)sender;

//-(NSString*) songTime;
//-(void) songCurrent: (UILabel*)tiempoQueTranscurre;

//- (void)updateProgressBar:(NSTimer *)timer tiempoQueTranscurre:(UILabel*)tiempoQueTranscurre;

//-(float) getVolumen;

- (void) nuevaCancionReproductor: (NSString*)nombreCancion;

@end
