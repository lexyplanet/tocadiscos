//
//  Disco.m
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "Disco.h"

@implementation Disco

-(void)girando: (UIImageView*) discoImageView
{
    [UIView animateWithDuration: 1
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveLinear
                     animations: ^{
                         discoImageView.transform = CGAffineTransformRotate(discoImageView.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished && animando) {
                             // if flag still set, keep spinning
                             [self girando:discoImageView];
                         }
                     }];
}

-(void)inicioGiro: (UIImageView*) discoImageView
{
    if (!animando) {
        animando = YES;
        [self girando:discoImageView];
    }
}

- (void) pararGiro
{
    // set the flag to stop spinning at the next 90 degree increment
    animando = NO;
}


@end
