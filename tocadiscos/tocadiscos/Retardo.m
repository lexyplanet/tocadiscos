//
//  Retardo.m
//  tocadiscos
//
//  Created by Lion User on 02/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "Retardo.h"

@implementation Retardo

- (void) tiempoEspera: (float)tiempo
{
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:tiempo]];
}

@end
