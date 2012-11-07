//
//  TocadiscosViewController.h
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

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
    float panActualFloat;
    float volumenActualFloat;
    float rateActualFloat;
    float timeActualFloat;
    NSString *cancionActual;

    BOOL pausado;   //Variable para el status de Pause ADRIAN
    
    //Creacón de objetos
    Sonido *sonido;
    Retardo *retardo;
    GiroBrazo *brazo;
    NSString *nombreImagenBrazo;
    Disco *disco;
    Animacion *animacion;
    PlayerPicker *playerPicker;
}

//PROPERTIES
//Sliders
@property (strong, nonatomic) IBOutlet TocadiscosSlider *panSlider; //para personalizar otro slider

@property (strong, nonatomic) IBOutlet TocadiscosSlider *volumenSlider; //para personalizar otro slider
@property (strong, nonatomic) IBOutlet TocadiscosSlider *rateSlider; //para personalizar Slider rate

//Información canción
@property (strong, nonatomic) IBOutlet UILabel *tiempoTranscurridoLabel;
@property (strong, nonatomic) IBOutlet UILabel *tiempoTotalLabel;
@property (strong, nonatomic) IBOutlet UIProgressView *cancionProgressView;

//Reproductor AudioPlayer
@property (nonatomic, strong) AVAudioPlayer *reproductorAudioPlayer; //PLAYERPICKER
@property (strong, nonatomic) IBOutlet UIImageView *discoImageView;
@property (strong, nonatomic) IBOutlet UIImageView *brazoAgujaImageView; //GIROBRAZO

//@property(nonatomic, strong) NSString* cancionActual;
@property(nonatomic, strong) NSTimer *timer; //ADRIAN

//Botones del tocadiscos
@property (nonatomic, strong) IBOutlet Boton *playButton; //PLAYERPICKER
@property (nonatomic, strong) IBOutlet Boton *pauseButton; //PLAYERPICKER
@property (nonatomic, strong) IBOutlet Boton *stopButton; //PLAYERPICKER


//ACTIONS
- (IBAction)Play:(id)sender;
- (IBAction)Pausa:(id)sender;
- (IBAction)Stop:(id)sender;



@end