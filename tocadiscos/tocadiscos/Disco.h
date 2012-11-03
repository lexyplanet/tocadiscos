//
//  Disco.h
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Disco : NSObject
{
    BOOL animando; //esta variable ayuda a saber si esta animando o corriendo el bucle.
}

-(void)girando: (UIImageView*) discoImageView; //Ejecuta el bucle o animación
-(void)inicioGiro: (UIImageView*) discoImageView;//Inicia el bucle o animación
-(void)pararGiro;//Para el bucle o animación

@end
