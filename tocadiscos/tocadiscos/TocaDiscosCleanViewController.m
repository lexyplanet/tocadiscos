//
//  TocadiscosCleanViewController.m
//  tocadiscos
//
//  Created by Lion User on 05/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "TocadiscosCleanViewController.h"

@interface TocadiscosCleanViewController ()

@end

@implementation TocadiscosCleanViewController

@synthesize volumenSlider;
@synthesize cancionProgressView;
@synthesize brazoAgujaImageView;
@synthesize discoImageView;
@synthesize playButton;
@synthesize stopButton;
@synthesize soundButton;


#pragma mark - Métodos clase ViewController
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
    
    //Inicialización de objetos
    sonido = [[Sonido alloc] init];
    retardo = [[Retardo alloc] init];
    brazo = [[GiroBrazo alloc] init];
    disco = [[Disco alloc] init];
    animacion = [[Animacion alloc] init];
    playerPicker = [[PlayerPicker alloc] init];
    funcionandoPicker = YES;
    
    /* Es necesario colocar la posición de x,y al modificar el anchorPoint el cual se utiliza para colocar el eje central donde se hará el giro */
    [brazo anchorPointGiroBrazo:brazoAgujaImageView PosicionX:227 andPosicionY:66 andAnclajeX:0.5 andAnclajeY:0.26];
    
    if (cancionActual == nil) {
        cancionActual = @"El tiempo se nos va";
    }
    
    if (funcionandoPicker) {
        [playerPicker iniciaReproductor:playButton andPauseButton:Nil andStopButton:stopButton andNombreCancion:cancionActual];
    }
    pausado = NO;
}

#pragma mark - Métodos heredados de la clase ViewController
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

- (void)viewDidUnload
{
    [self setCancionProgressView:nil];
    [self setDiscoImageView:nil];
    [self setBrazoAgujaImageView:nil];
    //[super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - IBActions
- (IBAction)Play:(id)sender {
    
    BOOL continua=YES; //Controla si hay algún error del picker
    //Controlar el error de no seleccionar ninguna canción en el picker
    if ( !funcionandoPicker || ![playerPicker verificaCancionActual:cancionActual] )
    {
        continua = NO;
    }
    
    if (continua)
    {
        if (!pausado)
        {
            [stopButton encender:@"stop-on@2x.png"];
            [playButton encender:@"hover-pause@2x.png"];
            if (funcionandoPicker) {                
                if(pause){
                    [playerPicker playButton:Nil];
                    pause = NO;                    
                }
                else{
                    //Sonido clic
                    [sonido setSonido:@"clic" andExtension:@"mp3"];
                    //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
                    [retardo tiempoEspera:0.25];
                    
                    //Animación
                    float time = 1.00;
                    [animacion inicioAnimacion:time];
                    
                    //Gira el brazo de la aguja
                    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:0.4];
                    [disco inicioGiro:discoImageView];
                    [animacion finAnimacion];
                    
                    //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
                    [retardo tiempoEspera:time];
                    
                    //Simula el sonido del contacto de la aguja sobre el vinilo
                    [sonido setSonido:@"Vinilo" andExtension:@"mp3"];
                    //Introduce una pausa para que la canción empiece después del sonido de la aguja sobre el vinilo
                    [retardo tiempoEspera:0.4];

                    [playerPicker playButton:cancionActual];
                }
            }
            pausado = YES;
        }
        else
        {
            [playButton encender:@"play-on.png"];
            if (funcionandoPicker) {                
                [playerPicker pauseButton];
            }
            pausado = NO;
            pause = YES;
        }
        [playerPicker volumen:volumenSlider];
    }
}

/*- (IBAction)Pausa:(id)sender {
  
}*/

- (IBAction)Stop:(id)sender {
    [playButton encender:@"active-play@2x.png"];
    [stopButton encender:@"stop-off@2x.png"];

    [animacion inicioAnimacion:1.0];
    [disco pararGiro];
    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:-0.01];
    [retardo tiempoEspera:0.25];
    [sonido setSonido:@"clic" andExtension:@"mp3"];
    [animacion finAnimacion];
    if (funcionandoPicker) {
        [playerPicker stopButton];
    }
    pause = NO;
    pausado = NO;
}

- (IBAction)cambioVolumen:(id)sender {
    if (funcionandoPicker) {
        [playerPicker volumen:volumenSlider];
    }
}

- (IBAction)volverRetro:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*Invoqué el metodo IBAction ya definido ya que contiene toda la animacion y play de la cancion*/
#pragma mark - nuevaCanción Piker
- (void) nuevaCancion: (NSString *) cancion
{
    //Pasamos el nombre de la canción eliminando su ruta y extensión
    cancionActual = [cancion lastPathComponent];
    if ([cancionActual hasSuffix:@".mp3"]) {
        [cancionActual stringByDeletingPathExtension];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Detiene la canción actual
    //[playButton apagar];
    [stopButton encender:@"stop-on@2x-png"];
    [animacion inicioAnimacion:1.0];
    [disco pararGiro];
    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:-0.01];
    [animacion finAnimacion];
    if (funcionandoPicker) {
        [playerPicker stopButton];
    }
    
    if ([segue.identifier isEqualToString:@"goToCanciones"])
    {
        NuevaCancionViewController * nuevaCancionViewController = (NuevaCancionViewController *) segue.destinationViewController;
        nuevaCancionViewController.delegate = self;
    }
}

@end