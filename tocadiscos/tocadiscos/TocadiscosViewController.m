//
//  TocadiscosViewController.m
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "TocadiscosViewController.h"
#import "NuevaCancionViewController.h"
#import "Sonido.h"
#import "Retardo.h"


@interface TocadiscosViewController ()

@end




@implementation TocadiscosViewController


@synthesize _sliderStereo;
@synthesize _sliderRate;
@synthesize _sliderVolumen;
@synthesize reproductor;
@synthesize barraProgreso; //ADRIAN
@synthesize brazoAgujaImageView; //GIROBRAZO
@synthesize discoImageView; //DISCO
@synthesize playButton;
@synthesize pauseButton;
@synthesize stopButton;

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
    
    /*************** PEDRO 3-11-2012 **************/
    //Inicializa el objeto de la clase Sonido
    sonido = [[Sonido alloc] init];
    //Inicializa el objeto de la clase Retardo
    retardo = [[Retardo alloc] init];
    //Inicializa el objeto de la clase GiroBrazo
    brazo = [[GiroBrazo alloc] init];
    //Inicializa el objeto de la clase Disco
    disco = [[Disco alloc] init];
    //Inicializa el objeto de la clase Animación
    animacion = [[Animacion alloc] init];
    //Inicializa el objeto de la clase PlayerPicker
    playerPicker = [[PlayerPicker alloc] init];
    
    sliderRetro= [[SliderRetro alloc] init];
    /*********************************************/
    
    
    //Personalizamos el slider de Stereo
    UIImage *minImage = [UIImage imageNamed:@"ControlStereoHorizontal-03.png"];
    UIImage *maxImage = [UIImage imageNamed:@"ControlStereoHorizontal-03.png"];
    UIImage *thumbImage = [UIImage imageNamed:@"BotonVolumenHorizontal-04.png"];
    
    minImage = [minImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    maxImage = [maxImage stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    
    [_sliderStereo setMinimumTrackImage:minImage forState:UIControlStateNormal];
    [_sliderStereo setMaximumTrackImage:maxImage forState:UIControlStateNormal];
    [_sliderStereo setThumbImage:thumbImage forState:UIControlStateNormal];
    
    minImage = nil;
    maxImage = nil;
    thumbImage = nil;
    
    //Giramos el slider de Stereo
    CGAffineTransform sliderVolumenRotacion = CGAffineTransformIdentity;
    sliderVolumenRotacion = CGAffineTransformRotate(sliderVolumenRotacion, -(M_PI / 2));
    self._sliderStereo.transform = sliderVolumenRotacion;
    
    [sliderRetro personalizar:self._sliderVolumen];
    
    /* Es necesario colocar la posición de x,y al modificar el anchorPoint el cual se utiliza para colocar el eje central donde se hará el giro
     */
    
    [brazo anchorPointGiroBrazo:brazoAgujaImageView PosicionX:190 andPosicionY:4 andAnclajeX:0.5 andAnclajeY:0.26];
    
    //Personalizamos el slider de velocidad
    UIImage *minImageVe = [UIImage imageNamed:@"ControlVelocidadHorizontal-02.png"];
    UIImage *maxImageVe = [UIImage imageNamed:@"ControlVelocidadHorizontal-02.png"];
    UIImage *thumbImageVe = [UIImage imageNamed:@"BotonControlVelocidadHorizontal-03.png"];
    
    minImageVe = [minImageVe stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    maxImageVe = [maxImageVe stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    
    [_sliderRate setMinimumTrackImage:minImageVe forState:UIControlStateNormal];
    [_sliderRate setMaximumTrackImage:maxImageVe forState:UIControlStateNormal];
    [_sliderRate setThumbImage:thumbImageVe forState:UIControlStateNormal];
    
    minImageVe = nil;
    maxImageVe = nil;
    thumbImageVe = nil;
    
    [playerPicker iniciaReproductor:playButton andPauseButton:pauseButton andStopButton:stopButton];
    
    /******************************** INICIALIZACION DE VARIABLE DE STATUS DE PAUSE (ADRIAN) *********************/
    
    pausado = NO;
    /*******************************************************************************************/
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Play:(id)sender
{
    //Pone el botón del play en color verde.
    [self.playButton setImage:[UIImage imageNamed:@"BotonPlayVerde.png"] forState:UIControlStateNormal];
    //Apaga el botón pause y stop
    [self.pauseButton setImage:NO forState:UIControlStateNormal];
    [self.stopButton setImage:NO forState:UIControlStateNormal];
    
    /********* PEDRO 3/11/2012 *********/
    //Sonido clic
    [sonido setSonido:@"clic" andExtension:@"mp3"];
    //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
    [retardo tiempoEspera:0.25];
    /*********************************/
    
    
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
    volumenActualFloat = self.reproductor.volume;
    //rateActualFloat = self.reproductor.rate;
    
    /* Asigna la nueva instancia al reproductor con los nuevos valores */
    NSError * error;
    NSURL *url = [[NSURL alloc] initFileURLWithPath:self.cancionActual];
    self.reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    
    self.reproductor.pan = panActualFloat;
    self.reproductor.volume = volumenActualFloat;
    
    /* Se vuelve a ajustar la propiedad EnableRate a YES para que la nueva instancia realize el Rate
     ya que por default una nueva instancia tiene un valor de NO asi que si asignamos una nueva instancia de AVAudioPlayer
     y despues lo reproducimos, si queremos cambiar el rate éste no lo hará (que es lo que pasaba) */
    self.reproductor.enableRate = YES;
    
    self.reproductor.rate = rateActualFloat;
    self.reproductor.currentTime = timeActualFloat;
    
    
    
    //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
    //[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:time]];
    [retardo tiempoEspera:time];
    
    /********* PEDRO 1/11/2012 *********/
    //Simula el sonido del contacto de la aguja sobre el vinilo
    [sonido setSonido:@"Vinilo" andExtension:@"mp3"];
    //Introduce una pausa para que la canción empiece después del sonido de la aguja sobre el vinilo
    [retardo tiempoEspera:0.4];
    /**********************************/
    
    //Comienza a sonar la canción
    [self.reproductor play];
    
    
    /******************************** VERSION ADRIAN PROGRESS BAR Y LABELS *********************/
    float duracionAudio = [self.reproductor duration];
    
    //Obteniendo los minutos
    float minutos = floor(duracionAudio/60);
    //Obteniendo los segundos del audio restando los minutos que lleva
    float segundos = duracionAudio - (minutos*60);
    
    //Inserta el tiempo total de la cancion.
    //Si los segundos son menores a 10 formatea el numero a mostrar
    if(segundos < 10)
    {
        //Ajuste del Label del tiempo transcurrido
        self.tiempoTotal.text = [NSString stringWithFormat:@"%0.0f:0%0.0f", minutos, segundos];
    } else {
        //Ajuste del Label del tiempo transcurrido
        self.tiempoTotal.text = [NSString stringWithFormat:@"%0.0f:%0.0f", minutos, segundos];
    }
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];
    /******************************************************************************/
}

/******************************* ACTUALIZA PROGRESSBAR (ADRIAN) ************************************/
#pragma mark - UpdateProgressBar
- (void)updateProgressBar:(NSTimer *)timer
{
    NSTimeInterval tiempoDelAudio = [self.reproductor currentTime];     //Tiempo actual del audio
    NSTimeInterval duracionTotalDelAudio = [self.reproductor duration]; //Tiempo total del audio
    float progreso = tiempoDelAudio / duracionTotalDelAudio;            //Progreso de la cancion
    [self.barraProgreso setProgress: progreso];                          //Ajusta el componente al progreso calculado
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
        self.tiempoQueTranscurre.text = [NSString stringWithFormat:@"%0.0f:0%0.0f", minutos, segundos];
    } else {
        //Ajuste del Label del tiempo transcurrido
        self.tiempoQueTranscurre.text = [NSString stringWithFormat:@"%0.0f:%0.0f", minutos, segundos];
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
    self.reproductor.currentTime = 0;
    timeActualFloat = self.reproductor.currentTime;
    [disco pararGiro];
    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:-0.01];
    [animacion finAnimacion];
    
    [self.reproductor stop];
}



- (IBAction)cambioVolumen:(id)sender
{
    self.reproductor.volume = ((UISlider *) sender).value;
    //NSLog(@"%f", self.reproductor.volume);
}

- (IBAction)cambioPan:(id)sender
{
    self.reproductor.pan = ((UISlider *) sender).value;
}

- (IBAction)cambioRate:(id)sender
{
    NSLog(@"%f", ((UISlider *) sender).value);
    self.reproductor.rate = ((UISlider *) sender).value;
}



- (void)viewDidUnload
{
    [self setBarraProgreso:nil];
    [self setDiscoImageView:nil];
    [self setBrazoAgujaImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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

/*Adrian: Invoqué el metodo IBAction ya definido ya que contiene toda la animacion y play de la cancion*/

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
