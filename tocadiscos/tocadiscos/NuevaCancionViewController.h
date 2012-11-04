//
//  NuevaCancionViewController.h
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>




@protocol NuevaCancionDelegate <NSObject>

@optional
- (void) nuevaCancion: (NSString *) cancion;
//SELECCIÓN NOMBRE CANCION
- (void) nuevaCancionSeleccionada: (NSString *) cancionSelec;
//SELECCIÓN NOMBRE CANCION


@end

NSInteger posUltimaCancion;

@interface NuevaCancionViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) id <NuevaCancionDelegate> delegate;
@property (nonatomic, strong) NSString *cancionSeleccionada;
//SELECCIÓN NOMBRE CANCION
@property (nonatomic, strong) NSString *nombreCancionSeleccionada;
//SELECCIÓN NOMBRE CANCION

@property (nonatomic, strong) NSArray *canciones;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *hechoBarButtonItem;
@property (strong, nonatomic) IBOutlet UIPickerView *pickerMusicItem;


- (IBAction) hecho:(id)sender;



@end
