//
//  SeleccionAlertView.m
//  tocadiscos
//
//  Created by Lion User on 07/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "SeleccionAlertView.h"

@implementation SeleccionAlertView

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

- (void) seleccionCancion
{
    UIAlertView *errorSeleccion = [[UIAlertView alloc] initWithTitle:@"RECUERDA" message:@"Elige la canción" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [errorSeleccion show];
}

@end
