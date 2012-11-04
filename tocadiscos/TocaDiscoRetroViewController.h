//
//  TocaDiscoRetroViewController.h
//  tocadiscos
//
//  Created by Beto on 04/11/12.
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

@interface TocaDiscoRetroViewController : UIViewController{
    /* Variables Auxiliares para el ajuste de valores en el reproductor al momento de cambiar de cancion */
    float panActualFloat;
    float volumenActualFloat;
    float rateActualFloat;
    float timeActualFloat;
    
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
    /*************************************/
}

@end
