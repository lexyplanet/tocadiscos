//
//  Sonido.m
//  tocadiscos
//
//  Created by Lion User on 02/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//
//majo

#import "Sonido.h"

@implementation Sonido

- (void) setSonido: (NSString*)nombreSonido
     andExtension: (NSString*)extensionFichero{
    
    rutaFichero = [[NSBundle mainBundle] pathForResource:nombreSonido ofType:extensionFichero];
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[NSURL fileURLWithPath:rutaFichero], &sonidoID);
    AudioServicesPlaySystemSound(sonidoID);
    
}

@end
