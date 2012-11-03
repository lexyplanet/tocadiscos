//
//  Sonido.h
//  tocadiscos
//
//  Created by Lion User on 02/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface Sonido : NSObject
{
    SystemSoundID sonidoID;
    NSString *rutaFichero;
}

- (void) setSonido: (NSString*)nombreSonido
     andExtension: (NSString*)extensionFichero;

@end
