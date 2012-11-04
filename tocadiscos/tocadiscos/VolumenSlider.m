//
//  VolumenSlider.m
//  tocadiscos
//
//  Created by Adrian de Jesus Piedra Goicochea on 04/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "VolumenSlider.h"

@implementation VolumenSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //Personalizamos el slider de volumen
    }
    return self;
}

- (void)personalizar
{
    UIImage *minImageV = [UIImage imageNamed:@"ControlVolumenHorizontal-02.png"];
    UIImage *maxImageV = [UIImage imageNamed:@"ControlVolumenHorizontal-02.png"];
    UIImage *thumbImageV = [UIImage imageNamed:@"BotonVolumenHorizontal-04.png"];
    
    minImageV = [minImageV stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    maxImageV = [maxImageV stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    
    [self setMinimumTrackImage:minImageV forState:UIControlStateNormal];
    [self setMaximumTrackImage:maxImageV forState:UIControlStateNormal];
    [self setThumbImage:thumbImageV forState:UIControlStateNormal];
    
    //Giramos el slider de volumen
    CGAffineTransform sliderStereoRotacion = CGAffineTransformIdentity;
    sliderStereoRotacion = CGAffineTransformRotate(sliderStereoRotacion, -(M_PI / 2));
    self.transform = sliderStereoRotacion;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
