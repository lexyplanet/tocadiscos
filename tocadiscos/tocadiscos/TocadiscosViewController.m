//
//  TocadiscosViewController.m
//  tocadiscos
//
//  Created by Lion User on 28/10/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "TocadiscosViewController.h"
#import "NuevaCancionViewController.h"


@interface TocadiscosViewController ()

@end




@implementation TocadiscosViewController

@synthesize _sliderVolumen;
@synthesize _sliderStereo;
@synthesize _sliderRate;
@synthesize reproductor;
@synthesize barraProgreso; //ADRIAN

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
        /* -------------------------------------------
     Cambio por: Beto
     Tipo movimiento: Giro de la aguja.
     
     Notas:
     Es necesario colocar la posición de x,y al modificar el anchorPoint el cual se utiliza para colocar el eje central donde se hará el giro
     */
    CGRect aguja = self.imagenAguja.frame; // Asignamos la variable aguja que trae las propiedades de la imagenAguja
    aguja.origin.x = 230; // Posicionamos la imagen de x
    aguja.origin.y = 23; //Posicionamos la imagen de y
    
    self.imagenAguja.layer.anchorPoint = CGPointMake(.5, .26); //Le decimos donde queremos anclar la imagen
    self.imagenAguja.frame = aguja; //Le asignamos los nuevos parametros a la imagen original de la aguja
    //oculto la barra de progreso
    self.barraProgreso.hidden = YES;
    
    /* fin Cambio por: Beto. ----------------------- */
    
    NSError * error;
    
    self.cancionActual = [[NSBundle mainBundle] pathForResource:@"Estopa. La primavera" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:self.cancionActual];
    self.reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    

    self.reproductor.volume = 0.5;
    
    [self.reproductor prepareToPlay];
    
    /******************************** INICIALIZACION DE VARIABLE DE STATUS DE PAUSE (ADRIAN) *********************/
    pausado = NO;
    /*******************************************************************************************/
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Play:(id)sender {
    //Comienza a sonar la canción
    //Animación
    float time = 1.00;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:time];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    if(pausado){
        [self moveAguja:@"right" aumenta:0];
        [self.reproductor pause];
        [self stopSpin];
        pausado=NO;
    }
    else{
        //Pone el botón del play en color verde.
        /*[self.playButton setImage:[UIImage imageNamed:@"BotonPlayVerde.png"] forState:UIControlStateNormal];
         */
        //Apaga el botón pause y stop
        /*[self.pauseButton setImage:NO forState:UIControlStateNormal];
         [self.stopButton setImage:NO forState:UIControlStateNormal];
         */
        
        
        
        /* Asignacion de los valores actuales del reproductor para que no se pierdan a la hora de reproducir la nueva instancia */
        
        //volumenActualFloat = self.reproductor.volume;
        
        
        
        /* Se vuelve a ajustar la propiedad EnableRate a YES para que la nueva instancia realize el Rate
         ya que por default una nueva instancia tiene un valor de NO asi que si asignamos una nueva instancia de AVAudioPlayer
         y despues lo reproducimos, si queremos cambiar el rate éste no lo hará (que es lo que pasaba) */

        
        //[self.reproductor prepareToPlay];
        
        //Codigo Adiconado por: Beto-------------
        //Mando llamara a la función en la cual le digo que se mueva hacia la dirección derecha
        /*-----------------------------------*/
        
        //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
        /********* PEDRO 1/11/2012 *********/
        //Hace el sonido de movimiento del brazo de la aguja
        
        [self startSpin];
        
        SystemSoundID soundID;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"clic" ofType:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[NSURL fileURLWithPath:path], &soundID);
        AudioServicesPlaySystemSound(soundID);

        //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.25]];
                        [self moveAguja:@"left" aumenta:.4];
        /*********************************/
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:time]];
        
        /********* PEDRO 1/11/2012 *********/
        //Simula el sonido del contacto de la aguja sobre el vinilo

        SystemSoundID viniloSoundID;
        NSString *pathVinilo = [[NSBundle mainBundle] pathForResource:@"Vinilo" ofType:@"mp3"];
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[NSURL fileURLWithPath:pathVinilo], &viniloSoundID);
        AudioServicesPlaySystemSound(viniloSoundID);
        //Introduce una pausa para que la canción empiece después del sonido de la aguja sobre el vinilo
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.4]];
        
        /**********************************/
         
        [self.reproductor play];
        pausado=YES;
        
        /******************************** VERSION ADRIAN PROGRESS BAR Y LABELS *********************/
        //aparece la barra de progreso
        self.barraProgreso.hidden = NO;
        
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
    
    
    
    [UIView commitAnimations];
}

/**********************************************************************************/
-(void) moveAguja:(NSString*)direccion aumenta:(float)aumenta{
    /*
     Creado por: Beto.
     Titulo: moveAguja.
     Nota.
     Metodo con el cual hacemos que la aguja se mueva en la direccion left or right, el parametro "aumenta" es por si deseamos que avance conforme al tiempo de la canción.
     */
    CGAffineTransform moverAguja = self.imagenAguja.transform;
    
    if(direccion==@"left")
        moverAguja = CGAffineTransformMakeRotation(self.imagenAguja.transform.tx+aumenta);
    else if(direccion==@"right")
        moverAguja = CGAffineTransformMakeRotation(aumenta);
    
    self.imagenAguja.transform = moverAguja;
}

/********************************************/

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

#pragma mark - Giro disco

-(void)spin{
    [UIView animateWithDuration: 1
                          delay: 0.0f
                        options: UIViewAnimationOptionCurveLinear
                     animations: ^{
                         self.imagenDisco.transform = CGAffineTransformRotate(self.imagenDisco.transform, M_PI / 2);
                     }
                     completion: ^(BOOL finished) {
                         if (finished && animating) {
                             // if flag still set, keep spinning
                             [self spin];
                         }
                     }];
}
-(void)startSpin{
    if (!animating) {
        animating = YES;
        [self spin];
    }
}

- (void) stopSpin {
    // set the flag to stop spinning at the next 90 degree increment
    animating = NO;
}

- (IBAction)Pausa:(id)sender {
    //Pone el botón del pause en color verde.
    /*[self.pauseButton setImage:[UIImage imageNamed:@"BotonPauseVerde.png"] forState:UIControlStateNormal];
    //Apaga el botón play y stop
    [self.playButton setImage:NO forState:UIControlStateNormal];
    [self.stopButton setImage:NO forState:UIControlStateNormal];
    */
    /********************* MODIFICACIÓN ADRIÁN *****************/
    if (pausado) {
        [self.reproductor play];
        pausado = NO;
        return;
    }
     /***********************************************************/
    
    
    /*etiqueta.text = [[NSString alloc] initWithFormat:@"duration: %4.2f \n currentTime %4.2f", self.reproductor.duration, self.reproductor.currentTime];*/
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.00];
    [UIView setAnimationBeginsFromCurrentState:YES];
    timeActualFloat = self.reproductor.currentTime;
    
    [self stopSpin];
    
    //etiqueta.text = 0;
    //Codigo Adicionado Por: Beto. LLamamos al metodo para regresarlo a su estado original.
    [self moveAguja:@"right" aumenta:0.0];
    
    [UIView commitAnimations];
    [self.reproductor pause];
}

- (IBAction)Stop:(id)sender {
    //Pone el botón del stop en color verde.
    /*[self.stopButton setImage:[UIImage imageNamed:@"BotonStopVerde.png"] forState:UIControlStateNormal];
    //Apaga el botón play y pause
    [self.playButton setImage:NO forState:UIControlStateNormal];
    [self.pauseButton setImage:NO forState:UIControlStateNormal];
    */
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.00];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.reproductor.currentTime = 0;
    timeActualFloat = self.reproductor.currentTime;
    [self stopSpin];
    //etiqueta.text = 0;
    
    //Codigo Adicionado Por: Beto. LLamamos al metodo para regresarlo a su estado original.
    [self moveAguja:@"right" aumenta:0.0];

    [UIView commitAnimations];
    //vuelvo a ocultar la barra de progreso
    self.barraProgreso.hidden = YES;
    
    [self.reproductor stop];
}



- (IBAction)cambioVolumen:(id)sender {
    self.reproductor.volume = ((UISlider *) sender).value;
    //NSLog(@"%f", self.reproductor.volume);
}

- (IBAction)cambioPan:(id)sender {
    self.reproductor.pan = ((UISlider *) sender).value;
}

- (IBAction)cambioRate:(id)sender {
    NSLog(@"%f", ((UISlider *) sender).value);
    self.reproductor.rate = ((UISlider *) sender).value;
}



- (void)viewDidUnload
{
    //[self setEtiqueta:nil]; ADRIAN
    //[self setTiempoQueTranscurre:nil]; ADRIAN
    //[self setTiempoTotal:nil]; ADRIAN
    [self setBarraProgreso:nil];
    [self setImagenDisco:nil];
    [self setImagenAguja:nil];
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
- (void) nuevaCancion: (NSString *) cancion;
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
