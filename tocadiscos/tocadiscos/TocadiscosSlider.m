//
//  TocadiscosSlider.m
//  tocadiscos
//
//  Created by Lion User on 05/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "TocadiscosSlider.h"

@implementation TocadiscosSlider

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)personalizarSlider:(NSString*)archivothumb
              andImagenMin:(NSString*)archivoImageMin
              andImagenMax:(NSString*)archivoImageMax
               andVertical:(BOOL)vertical
{
    UIImage *minImageV = [UIImage imageNamed:archivoImageMin];
    UIImage *maxImageV = [UIImage imageNamed:archivoImageMax];
    UIImage *thumbImageV = [UIImage imageNamed:archivothumb];
    
    minImageV = [minImageV stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    maxImageV = [maxImageV stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    
    [self setMinimumTrackImage:minImageV forState:UIControlStateNormal];
    [self setMaximumTrackImage:maxImageV forState:UIControlStateNormal];
    [self setThumbImage:thumbImageV forState:UIControlStateNormal];
    
    //Giramos el slider de volumen a vertical si es True
    if(vertical)
    {
        CGAffineTransform sliderStereoRotacion = CGAffineTransformIdentity;
        sliderStereoRotacion = CGAffineTransformRotate(sliderStereoRotacion, -(M_PI / 2));
        self.transform = sliderStereoRotacion;
    }
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
