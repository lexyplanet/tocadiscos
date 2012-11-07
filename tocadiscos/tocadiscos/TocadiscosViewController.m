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
@synthesize reproductorAudioPlayer;
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
    //playerPicker = [[PlayerPicker alloc] init];
    
    //Apagar botones
    [playButton apagar];
    
    //Personalización de los sliders
    [panSlider personalizarSlider:@"ControlStereoHorizontal-03.png" andImagenMin:@"ControlStereoHorizontal-03.png" andImagenMax:@"BotonVolumenHorizontal-04.png" andVertical:YES];
    
    [volumenSlider personalizarSlider:@"ControlVelocidadHorizontal-02.png" andImagenMin:@"ControlVelocidadHorizontal-02.png" andImagenMax:@"BotonControlVelocidadHorizontal-04.png" andVertical:YES];
    
    [rateSlider personalizarSlider:@"ControlVelocidadHorizontal-02.png" andImagenMin:@"ControlVelocidadHorizontal-02.png" andImagenMax:@"BotonControlVelocidadHorizontal-03.png" andVertical:NO];
    
    
    /* Es necesario colocar la posición de x,y al modificar el anchorPoint el cual se utiliza para colocar el eje central donde se hará el giro */
    [brazo anchorPointGiroBrazo:brazoAgujaImageView PosicionX:190 andPosicionY:4 andAnclajeX:0.5 andAnclajeY:0.26];
    
    //[playerPicker iniciaReproductor:playButton andPauseButton:pauseButton andStopButton:stopButton];
    //[reproductorAudioPlayer iniciaReproductor:playButton andPauseButton:pauseButton andStopButton:stopButton];
    
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

#pragma mark - IBActions
- (IBAction)Play:(id)sender
{
    //Sonido clic
    [sonido setSonido:@"clic" andExtension:@"mp3"];
    //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
    [retardo tiempoEspera:0.25];

    //Animación
    float time = 1.00;
    [animacion inicioAnimacion:time];
    
    //Gira el brazo de la aguja
    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:0.4];
    
    //[self startSpin];
    [disco inicioGiro:discoImageView];
    
    [animacion finAnimacion];
    
    /* Asignacion de los valores actuales del reproductor para que no se pierdan a la hora de reproducir la nueva instancia */
    //panActualFloat = self.reproductor.pan;
    volumenActualFloat = self.reproductorAudioPlayer.volume;
    //rateActualFloat = self.reproductor.rate;
    
    /* Asigna la nueva instancia al reproductor con los nuevos valores */
    /*NSError * error;
    NSURL *url = [[NSURL alloc] initFileURLWithPath:self.cancionActual];
    self.reproductorAudioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];*/
    
    self.reproductorAudioPlayer.pan = panActualFloat;
    self.reproductorAudioPlayer.volume = volumenActualFloat;
    
    /* Se vuelve a ajustar la propiedad EnableRate a YES para que la nueva instancia realize el Rate
     ya que por default una nueva instancia tiene un valor de NO asi que si asignamos una nueva instancia de AVAudioPlayer
     y despues lo reproducimos, si queremos cambiar el rate éste no lo hará (que es lo que pasaba) */
    self.reproductorAudioPlayer.enableRate = YES;
    
    self.reproductorAudioPlayer.rate = rateActualFloat;
    self.reproductorAudioPlayer.currentTime = timeActualFloat;

    //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
    [retardo tiempoEspera:time];

    //Simula el sonido del contacto de la aguja sobre el vinilo
    [sonido setSonido:@"Vinilo" andExtension:@"mp3"];
    //Introduce una pausa para que la canción empiece después del sonido de la aguja sobre el vinilo
    [retardo tiempoEspera:0.4];

    //Comienza a sonar la canción
    [self.reproductorAudioPlayer play];
}

- (IBAction)Pausa:(id)sender {
    //Pone el botón del pause en color verde.
    [self.pauseButton setImage:[UIImage imageNamed:@"BotonPauseVerde.png"] forState:UIControlStateNormal];
    //Apaga el botón play y stop
    [self.playButton setImage:NO forState:UIControlStateNormal];
    [self.stopButton setImage:NO forState:UIControlStateNormal];
    
    /********************* MODIFICACIÓN ADRIÁN *****************/
    if (pausado) {
        //[self.reproductor play];
        pausado = NO;
        return;
    }
}

- (IBAction)Stop:(id)sender
{
    //Pone el botón del stop en color verde.
    [self.stopButton setImage:[UIImage imageNamed:@"BotonStopVerde.png"] forState:UIControlStateNormal];
    //Apaga el botón play y pause
    [self.playButton setImage:NO forState:UIControlStateNormal];
    [self.pauseButton setImage:NO forState:UIControlStateNormal];
    
    [animacion inicioAnimacion:1.0];
    self.reproductorAudioPlayer.currentTime = 0;
    timeActualFloat = self.reproductorAudioPlayer.currentTime;
    [disco pararGiro];
    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:-0.01];
    [animacion finAnimacion];
    
    [self.reproductorAudioPlayer stop];
}



- (IBAction)cambioVolumen:(id)sender
{
    self.reproductorAudioPlayer.volume = ((UISlider *) sender).value;
    //NSLog(@"%f", self.reproductor.volume);
}

- (IBAction)cambioPan:(id)sender
{
    self.reproductorAudioPlayer.pan = ((UISlider *) sender).value;
}

- (IBAction)cambioRate:(id)sender
{
    NSLog(@"%f", ((UISlider *) sender).value);
    self.reproductorAudioPlayer.rate = ((UISlider *) sender).value;
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



/******************************* ACTUALIZA PROGRESSBAR (ADRIAN) ************************************/
#pragma mark - UpdateProgressBar
- (void)updateProgressBar:(NSTimer *)timer
{
    NSTimeInterval tiempoDelAudio = [self.reproductorAudioPlayer currentTime];     //Tiempo actual del audio
    NSTimeInterval duracionTotalDelAudio = [self.reproductorAudioPlayer duration]; //Tiempo total del audio
    float progreso = tiempoDelAudio / duracionTotalDelAudio;            //Progreso de la cancion
    [self.cancionProgressView setProgress: progreso];                          //Ajusta el componente al progreso calculado
    //NSLog(@"%f", self.barraProgreso.progress);
    
    //Obteniendo los minutos
    float minutos = floor(tiempoDelAudio/60);
    //Obteniendo los segundos del audio restando los minutos que lleva
    float segundos = tiempoDelAudio - (minutos*60);
    
    //Evita que en el label aparezca el seg 60
    if(segundos > 59)
    {
        segundos = 0.0;
        minutos += 1;
    }
    
    //Si los segundos son menores a 10 formatea el numero a mostrar
    if(segundos <= 9)
    {
        //Ajuste del Label del tiempo transcurrido
        self.tiempoTranscurridoLabel.text = [NSString stringWithFormat:@"%0.0f:0%0.0f", minutos, segundos];
    } else {
        //Ajuste del Label del tiempo transcurrido
        self.tiempoTranscurridoLabel.text = [NSString stringWithFormat:@"%0.0f:%0.0f", minutos, segundos];
    }
}


/*Adrian: Invoqué el metodo IBAction ya definido ya que contiene toda la animacion y play de la cancion*/
#pragma mark - nuevaCanción Piker
- (void) nuevaCancion: (NSString *) cancion
{
    self.cancionActual = cancion;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"goToCanciones"])
    {
        NuevaCancionViewController * nuevaCancionViewController = (NuevaCancionViewController *) segue.destinationViewController;
        nuevaCancionViewController.delegate = self;
        
    }
}

@end
