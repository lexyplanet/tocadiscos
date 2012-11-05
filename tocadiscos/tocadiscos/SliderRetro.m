//
//  SliderRetro.m
//  tocadiscos
//
//  Created by Lion User on 05/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "SliderRetro.h"

@implementation SliderRetro

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)personalizar:(UISlider*)volumenSlider
{
    UIImage *minImageV = [UIImage imageNamed:@"ControlVolumenHorizontal-02.png"];
    UIImage *maxImageV = [UIImage imageNamed:@"ControlVolumenHorizontal-02.png"];
    UIImage *thumbImageV = [UIImage imageNamed:@"BotonVolumenHorizontal-04.png"];
    
    minImageV = [minImageV stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    maxImageV = [maxImageV stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    
    [volumenSlider setMinimumTrackImage:minImageV forState:UIControlStateNormal];
    [volumenSlider setMaximumTrackImage:maxImageV forState:UIControlStateNormal];
    [volumenSlider setThumbImage:thumbImageV forState:UIControlStateNormal];
    
    //Giramos el slider de volumen
    CGAffineTransform sliderStereoRotacion = CGAffineTransformIdentity;
    sliderStereoRotacion = CGAffineTransformRotate(sliderStereoRotacion, -(M_PI / 2));
    volumenSlider.transform = sliderStereoRotacion;
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
