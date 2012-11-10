//
//  TocadiscosViewController.m
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//...

#import "TocadiscosViewController.h"
#import "NuevaCancionViewController.h"
#import "Sonido.h"
#import "Retardo.h"


@interface TocadiscosViewController ()

@end

@implementation TocadiscosViewController

@synthesize panSlider;
@synthesize rateSlider;
@synthesize volumenSlider;
@synthesize cancionProgressView;
@synthesize brazoAgujaImageView;
@synthesize discoImageView;
@synthesize playButton;
@synthesize pauseButton;
@synthesize stopButton;

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
    self.nombreCancionLabel.text  =@"holahola ";
    
    /* Es necesario colocar la posición de x,y al modificar el anchorPoint el cual se utiliza para colocar el eje central donde se hará el giro */
    [brazo anchorPointGiroBrazo:brazoAgujaImageView PosicionX:220 andPosicionY:4 andAnclajeX:0.5 andAnclajeY:0.26];
    
    //Personalización de los sliders
    [panSlider personalizarSlider:@"BotonVolumenHorizontal-04.png" andImagenMin:@"ControlStereoHorizontal-03.png" andImagenMax:@"ControlStereoHorizontal-03.png" andVertical:YES];
    
    [volumenSlider personalizarSlider:@"BotonVolumenHorizontal-04.png" andImagenMin:@"ControlVolumenHorizontal-02.png" andImagenMax:@"ControlVolumenHorizontal-02.png" andVertical:YES];
    
    [rateSlider personalizarSlider:@"BotonControlVelocidadHorizontal-03.png" andImagenMin:@"ControlVelocidadHorizontal-02.png" andImagenMax:@"ControlVelocidadHorizontal-02.png" andVertical:NO];
    
    
    
    
    if (cancionActual == nil) {
        cancionActual = @"El tiempo se nos va";
    }
    
    if (funcionandoPicker) {
        [playerPicker iniciaReproductor:playButton andPauseButton:pauseButton andStopButton:stopButton andNombreCancion:cancionActual];
    }
    pausado = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
- (IBAction)Play:(id)sender
{
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
            [playButton encender:@"BotonPlayPulsado.png"];
            [pauseButton apagar];
            [stopButton apagar];
            
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
            
            if (funcionandoPicker) {
                [playerPicker playButton:cancionActual];
            }
          }
        else
        {
            [playButton encender:@"BotonPlayPulsado.png"];
            [pauseButton apagar];
            pausado = NO;
            if (funcionandoPicker) {
                [playerPicker playButton:Nil];
            }
        }
        //Colocamos el volumen al porcentaje con el que inicia.
        [playerPicker volumen:volumenSlider];
    }
}

- (IBAction)Pausa:(id)sender {
    if (!pausado) {
        [playButton apagar];
        [pauseButton encender:@"BotonPausePulsado.png"];
        [stopButton apagar];
        if (funcionandoPicker) {
            [playerPicker pauseButton];
        }
        pausado = YES;
    }
}

- (IBAction)Stop:(id)sender
{
    [playButton apagar];
    [pauseButton apagar];
    [stopButton encender:@"BotonStopPulsado.png"];
    [animacion inicioAnimacion:1.0];
    [disco pararGiro];
    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:-0.01];
    [retardo tiempoEspera:0.25];
    [sonido setSonido:@"clic" andExtension:@"mp3"];
    [animacion finAnimacion];
    if (funcionandoPicker) {
        [playerPicker stopButton];
    }
}

- (IBAction)cambioVolumen:(id)sender {
    if (funcionandoPicker) {
        [playerPicker volumen:volumenSlider];
    }
}

- (IBAction)cambioPan:(id)sender {
    if (funcionandoPicker) {
        [playerPicker pan:panSlider];
    }

}

- (IBAction)cambioRate:(id)sender {
    if (funcionandoPicker) {
        [playerPicker rate:rateSlider];
    }
}

/******************************* ACTUALIZA PROGRESSBAR (ADRIAN) ************************************/
#pragma mark - UpdateProgressBar
- (void)updateProgressBar:(NSTimer *)timer
{
    //NSTimeInterval tiempoDelAudio = [self.reproductorAudioPlayer currentTime];     //Tiempo actual del audio
    //NSTimeInterval duracionTotalDelAudio = [self.reproductorAudioPlayer duration]; //Tiempo total del audio
    //float progreso = tiempoDelAudio / duracionTotalDelAudio;            //Progreso de la cancion
    //[self.cancionProgressView setProgress: progreso];                          //Ajusta el componente al progreso calculado
    //NSLog(@"%f", self.barraProgreso.progress);
    
    //Obteniendo los minutos
    //float minutos = floor(tiempoDelAudio/60);
    //Obteniendo los segundos del audio restando los minutos que lleva
    //float segundos = tiempoDelAudio - (minutos*60);
    
    //Evita que en el label aparezca el seg 60
    /*if(segundos > 59)
    {
        segundos = 0.0;
        minutos += 1;
    }*/
    
    //Si los segundos son menores a 10 formatea el numero a mostrar
    /*if(segundos <= 9)
    {
        //Ajuste del Label del tiempo transcurrido
        self.tiempoTranscurridoLabel.text = [NSString stringWithFormat:@"%0.0f:0%0.0f", minutos, segundos];
    } else {
        //Ajuste del Label del tiempo transcurrido
        self.tiempoTranscurridoLabel.text = [NSString stringWithFormat:@"%0.0f:%0.0f", minutos, segundos];
    }*/
}


/*Invoqué el metodo IBAction ya definido ya que contiene toda la animacion y play de la cancion*/
- (void) nuevaCancion: (NSString *) cancion :(int) pos
{
    if ([cancion isEqualToString:@"SELECCIONA CANCIÓN:"])
    {
        nombreCancion=@" ";
    }
    //Pasamos el nombre de la canción eliminando su ruta y extensión
    cancionActual = [cancion lastPathComponent];
    if ([cancionActual hasSuffix:@".mp3"]) {
        nombreCancion =[cancionActual stringByDeletingPathExtension];
        
    }
    self.nombreCancionLabel.text = [NSString stringWithFormat:@"%@",nombreCancion];
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Detiene la canción actual
    [playButton apagar];
    [pauseButton apagar];
    [stopButton encender:@"BotonStopPulsado.png"];
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
