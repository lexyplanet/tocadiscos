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
#import "BotonesRetro.h"
#import "SliderRetro.h"

@interface TocadiscosViewController : UIViewController  <NuevaCancionDelegate>
{
    //REPRODUCTOR 
    /* Variables Auxiliares para el ajuste de valores en el reproductor al momento de cambiar de cancion */
    float panActualFloat;
    float volumenActualFloat;
    float rateActualFloat;
    float timeActualFloat;
    
    //IBOutlet UISlider *_sliderVolumen;//para personalizar un slider de Volumen
    
    IBOutlet UISlider *_sliderStereo;//para personalizar un slider de Stereo
    IBOutlet UISlider *_sliderRate; //para personalizar un slider de rate
    //BOOL animating; //esta variable ayuda a saber si esta animando o corriendo el bucle.GIRODISCO
    BOOL pausado;   //Variable para el status de Pause ADRIAN
    
    /********* PEDRO 3-11-2012 *************/
    //Objeto para escuchar un sonido
    Sonido *sonido;
    //Objeto para crear un retardo en la ejecución del programa
    Retardo *retardo;
    //Objeto para realizar el giro del brazo de la aguja
    GiroBrazo *brazo;
    NSString *nombreImagenBrazo;
    //Objeto para hacer girar el disco
    Disco *disco;
    //Objeto para crear animaciones
    Animacion *animacion;
    //Objeto para crear el player que selecciona las canciones mediante el Picker
    PlayerPicker *playerPicker;
    SliderRetro* sliderRetro;
    /*************************************/
}


@property (strong, nonatomic) IBOutlet UISlider *_sliderStereo; //para personalizar otro slider

@property (strong, nonatomic) IBOutlet UISlider *_sliderVolumen; //para personalizar otro slider

@property (strong, nonatomic) IBOutlet UISlider *_sliderRate; //para personalizar Slider rate

@property (strong, nonatomic) IBOutlet UILabel *tiempoQueTranscurre;
@property (strong, nonatomic) IBOutlet UILabel *tiempoTotal;
@property (strong, nonatomic) IBOutlet UIProgressView *barraProgreso;

@property (nonatomic, strong) AVAudioPlayer *reproductor; //PLAYERPICKER
@property (strong, nonatomic) IBOutlet UIImageView *discoImageView;
@property (strong, nonatomic) IBOutlet UIImageView *brazoAgujaImageView; //GIROBRAZO

@property(nonatomic, strong) NSString* cancionActual; //PLAYERPICKER
@property(nonatomic, strong) NSTimer *timer; //ADRIAN

//Botones del tocadiscos
@property (nonatomic, strong) IBOutlet UIButton *playButton; //PLAYERPICKER
@property (nonatomic, strong) IBOutlet UIButton *pauseButton; //PLAYERPICKER
@property (nonatomic, strong) IBOutlet UIButton *stopButton; //PLAYERPICKER

- (IBAction)Play:(id)sender;
- (IBAction)Pausa:(id)sender;
- (IBAction)Stop:(id)sender;
- (IBAction)cambioVolumen:(id)sender;
- (IBAction)cambioPan:(id)sender;
- (IBAction)cambioRate:(id)sender;

- (void)updateProgressBar:(NSTimer *)timer; //BORRAR - SOLO PARA QUITAR MENSAJES WARNING
- (void) nuevaCancion: (NSString *) cancion;

//Agregue estas 3 funciones que controlan el bucle.
/*-(void)spin; //Ejecuta el bucle o animación GIRODISCO
 -(void)startSpin;//Inicia el bucle o animación GIRODISCO
 -(void)stopSpin;//Para el bucle o animación GIRODISCO */
//-----------

@end