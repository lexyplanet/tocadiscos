//
//  NuevaCancionViewController.h
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "SeleccionAlertView.h"



@protocol NuevaCancionDelegate <NSObject>

@optional
- (void) nuevaCancion: (NSString *) cancion :(NSInteger) pos;

@end

int posUltimaCancion;

@interface NuevaCancionViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    NSString *cancion_elegida;
}

@property (nonatomic, strong) id <NuevaCancionDelegate> delegate;
@property (nonatomic, strong) NSString *cancionSeleccionada;
@property (nonatomic, strong) NSArray *canciones;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *hechoBarButtonItem;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerMusicItem;


- (IBAction) hecho:(id)sender;

@end
