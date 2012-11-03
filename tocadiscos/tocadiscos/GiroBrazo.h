//
//  GiroBrazo.h
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface GiroBrazo : NSObject

- (void) anchorPointGiroBrazo: (UIImageView*)brazoImageView
                    PosicionX: (float)posicionX
                  andPosicionY: (float)posicionY
                  andAnclajeX: (float)anclajeX
                  andAnclajeY: (float)anclajeY;

- (void) giroBrazo: (UIImageView*)brazoImageView
     andGradosGiro: (float)gradoGiro;

@end
