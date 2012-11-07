//
//  Boton.m
//  tocadiscos
//
//  Created by Lion User on 06/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "Boton.h"

@implementation Boton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark- Funciones Tocadiscos

- (void) apagar
{
    [self setImage:NO forState:UIControlStateNormal];
}


- (void) encender
{
    [self setImage:[UIImage imageNamed:nombreImagen] forState:UIControlStateNormal];
}



@end
