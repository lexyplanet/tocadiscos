//
//  TocadiscosViewController.h
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "NuevaCancionViewController.h"

@interface TocadiscosViewController : UIViewController  <NuevaCancionDelegate>

{
    /* Variables Auxiliares para el ajuste de valores en el reproductor al momento de cambiar de cancion */
    float panActualFloat;
    float volumenActualFloat;
    float rateActualFloat;
    float timeActualFloat;
    
    IBOutlet UISlider *_sliderVolumen;//para personalizar un slider de Volumen
    IBOutlet UISlider *_sliderStereo;//para personalizar un slider de Stereo
    IBOutlet UISlider *_sliderRate; //para personalizar un slider de rate
    BOOL animating; //esta variable ayuda a saber si esta animando o corriendo el bucle.
}
@property (strong, nonatomic) IBOutlet UISlider *_sliderVolumen; //para personalizar un slider
@property (strong, nonatomic) IBOutlet UISlider *_sliderStereo; //para personalizar otro slider
@property (strong, nonatomic) IBOutlet UISlider *_sliderRate; //para personalizar Slider rate

@property (strong, nonatomic) IBOutlet UILabel *tiempoQueTranscurre;
@property (strong, nonatomic) IBOutlet UILabel *tiempoTotal;
@property (strong, nonatomic) IBOutlet UIProgressView *barraProgreso;

@property (nonatomic, strong) AVAudioPlayer * reproductor;
@property (strong, nonatomic) IBOutlet UILabel *etiqueta;
@property (strong, nonatomic) IBOutlet UIImageView *imagenDisco;
@property (strong, nonatomic) IBOutlet UIImageView *imagenAguja;

@property(nonatomic, strong) NSString* cancionActual;
@property(nonatomic, strong) NSString* nombreCancionActual;

- (IBAction)Play:(id)sender;
- (IBAction)Pausa:(id)sender;
- (IBAction)Stop:(id)sender;
- (IBAction)cambioVolumen:(id)sender;
- (IBAction)cambioPan:(id)sender;
- (IBAction)cambioRate:(id)sender;

//Agregue estas 3 funciones que controlan el bucle.
-(void)spin; //Ejecuta el bucle o animación
-(void)startSpin;//Inicia el bucle o animación
-(void)stopSpin;//Para el bucle o animación
//-----------




@end