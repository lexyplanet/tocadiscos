//
//  GiroBrazo.m
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "GiroBrazo.h"


@implementation GiroBrazo

- (void) anchorPointGiroBrazo: (UIImageView*)brazoImageView
                    PosicionX: (float)posicionX
                 andPosicionY: (float)posicionY
                  andAnclajeX: (float)anclajeX
                  andAnclajeY: (float)anclajeY
{
    /* Es necesario colocar la posición de x,y al modificar el anchorPoint el cual se utiliza para colocar el eje central donde se hará el giro */
    CGRect brazo = brazoImageView.frame; // Asignamos la variable aguja que trae las propiedades de la imagenAguja
    brazo.origin.x = 190; // Posicionamos la imagen de x
    brazo.origin.y = 4; //Posicionamos la imagen de y
    brazoImageView.layer.anchorPoint = CGPointMake(anclajeX, anclajeY); //Le decimos donde queremos anclar la imagen
    brazoImageView.frame = brazo; //Le asignamos los nuevos parametros a la imagen original de la aguja
}

- (void) giroBrazo: (UIImageView*)brazoImageView
     andGradosGiro: (float)gradoGiro
{
    CGAffineTransform giraBrazo = brazoImageView.transform;
    giraBrazo = CGAffineTransformMakeRotation(gradoGiro);
    brazoImageView.transform = giraBrazo;
}

@end
