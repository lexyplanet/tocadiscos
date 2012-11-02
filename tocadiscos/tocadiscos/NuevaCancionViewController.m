//
//  NuevaCancionViewController.m
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "NuevaCancionViewController.h"
#import "TocadiscosViewController.h"


@interface NuevaCancionViewController ()

@end


@implementation NuevaCancionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.canciones = [[NSArray alloc] initWithObjects:@"Estopa. La primavera", @"Estopa. Cuerpo Triste",nil];
    
    posUltimaCancion = self.pickerMusicItem.tag;
    self.pickerMusicItem.tag = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



- (NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.canciones count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.canciones objectAtIndex:row];
}


/*Adrian Modifique el metodo solo añadiendo el volver al seleccionar la cancion*/
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *cancion_elegida = [NSString stringWithFormat:@"%@",[ self.canciones objectAtIndex:row]];
    
    posUltimaCancion= row;
    
    self.cancionSeleccionada = [[NSBundle mainBundle] pathForResource: cancion_elegida ofType:@"mp3"];
}



- (IBAction) hecho:(id)sender
{
    [self.delegate nuevaCancion: self.cancionSeleccionada];
    
    // [self.delegate].posUltimaCancion = self.pickerMusicItem.;
    //[self.delegate].tiempoQueTranscurre = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)viewDidUnload {
    [self setHechoBarButtonItem:nil];
    [self setPickerMusicItem:nil];
    [super viewDidUnload];
}
@end
