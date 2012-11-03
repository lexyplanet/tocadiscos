//
//  Animacion.m
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "Animacion.h"

@implementation Animacion

- (void) inicioAnimacion: (float)tiempo
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:tiempo];
    [UIView setAnimationBeginsFromCurrentState:YES];
}

- (void) finAnimacion
{
    [UIView commitAnimations];
}

@end
