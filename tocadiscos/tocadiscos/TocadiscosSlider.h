//
//  TocadiscosSlider.h
//  tocadiscos
//
//  Created by Lion User on 05/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TocadiscosSlider : UISlider

- (void)personalizarSlider:(NSString*)archivothumb
        andImagenMin:(NSString*)archivoImageMin
        andImagenMax:(NSString*)archivoImageMax
         andVertical:(BOOL)vertical;

@end
