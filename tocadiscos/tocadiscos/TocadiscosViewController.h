//
//  TocadiscosViewController.h
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//...

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "NuevaCancionViewController.h"
#import "Sonido.h"
#import "Retardo.h"
#import "GiroBrazo.h"
#import "Disco.h"
#import "Animacion.h"
#import "PlayerPicker.h"
#import "Boton.h"
#import "TocadiscosSlider.h"

@interface TocadiscosViewController : UIViewController  <NuevaCancionDelegate>
{
    NSString *cancionActual;
    NSString *nombreCancion;
    
    BOOL pausado;   //Variable para el status de Pause
    
    //Creación de objetos
    Sonido *sonido;
    Retardo *retardo;
    GiroBrazo *brazo;
    NSString *nombreImagenBrazo;
    Disco *disco;
    Animacion *animacion;
    PlayerPicker *playerPicker;
    
    BOOL funcionandoPicker; //Controla la selección de canciones del picker o del mediaPlayer.
    
}
////////////
//PROPERTIES
//Sliders
@property (strong, nonatomic) IBOutlet TocadiscosSlider *panSlider;
@property (strong, nonatomic) IBOutlet TocadiscosSlider *volumenSlider;
@property (strong, nonatomic) IBOutlet TocadiscosSlider *rateSlider;

//Información canción
@property (strong, nonatomic) IBOutlet UILabel *tiempoTranscurridoLabel;
@property (strong, nonatomic) IBOutlet UILabel *tiempoTotalLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *cancionProgressView;
@property (strong, nonatomic) IBOutlet UILabel *nombreCancionLabel;

//Reproductor AudioPlayer
//@property (nonatomic, strong) AVAudioPlayer *reproductorAudioPlayer;
@property (strong, nonatomic) IBOutlet UIImageView *discoImageView;
@property (strong, nonatomic) IBOutlet UIImageView *brazoAgujaImageView;

@property(nonatomic, strong) NSTimer *timer;

//Botones del tocadiscos
@property (nonatomic, strong) IBOutlet Boton *playButton;
@property (nonatomic, strong) IBOutlet Boton *pauseButton;
@property (nonatomic, strong) IBOutlet Boton *stopButton;

//ACTIONS
- (IBAction)Play:(id)sender;
- (IBAction)Pausa:(id)sender;
- (IBAction)Stop:(id)sender;

- (IBAction)cambioVolumen:(id)sender;
- (IBAction)cambioPan:(id)sender;
- (IBAction)cambioRate:(id)sender;

@end