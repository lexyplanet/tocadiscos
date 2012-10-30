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
    //[super viewDidLoad];
    
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
    
    //Personalizamos el slider de volumen
    UIImage *minImageV = [UIImage imageNamed:@"ControlVolumenHorizontal-02.png"];
    UIImage *maxImageV = [UIImage imageNamed:@"ControlVolumenHorizontal-02.png"];
    UIImage *thumbImageV = [UIImage imageNamed:@"BotonVolumenHorizontal-04.png"];
    
    minImageV = [minImageV stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    maxImageV = [maxImageV stretchableImageWithLeftCapWidth:10.0 topCapHeight:0.0];
    
    [_sliderVolumen setMinimumTrackImage:minImageV forState:UIControlStateNormal];
    [_sliderVolumen setMaximumTrackImage:maxImageV forState:UIControlStateNormal];
    [_sliderVolumen setThumbImage:thumbImageV forState:UIControlStateNormal];
    
    minImageV = nil;
    maxImageV = nil;
    thumbImageV = nil;
    
    //Giramos el slider de volumen
    CGAffineTransform sliderStereoRotacion = CGAffineTransformIdentity;
    sliderStereoRotacion = CGAffineTransformRotate(sliderStereoRotacion, -(M_PI / 2));
    self._sliderVolumen.transform = sliderStereoRotacion;
    
    /* -------------------------------------------
     Cambio por: Beto
     Tipo movimiento: Giro de la aguja.
     
     Notas:
     Es necesario colocar la posición de x,y al modificar el anchorPoint el cual se utiliza para colocar el eje central donde se hará el giro
     */
    CGRect aguja = self.imagenAguja.frame; // Asignamos la variable aguja que trae las propiedades de la imagenAguja
    aguja.origin.x = 190; // Posicionamos la imagen de x
    aguja.origin.y = 4; //Posicionamos la imagen de y
    
    self.imagenAguja.layer.anchorPoint = CGPointMake(.5, .26); //Le decimos donde queremos anclar la imagen
    self.imagenAguja.frame = aguja; //Le asignamos los nuevos parametros a la imagen original de la aguja
    
    
    /* fin Cambio por: Beto. ----------------------- */
    
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
    NSError * error;
    
    self.cancionActual = [[NSBundle mainBundle] pathForResource:@"Estopa. La primavera" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:self.cancionActual];
    self.reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    
    self.reproductor.pan = 0;
    self.reproductor.volume = 0.5;
    
    self.reproductor.enableRate = YES;
    self.reproductor.rate = 1;
    [self.reproductor prepareToPlay];
   
    //Se oculta las imagenes asignadas a los botones del tocadiscos (play, pause, stop)
    [self.playButton setImage:NO forState:UIControlStateNormal];
    [self.pauseButton setImage:NO forState:UIControlStateNormal];
    [self.stopButton setImage:NO forState:UIControlStateNormal];
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Play:(id)sender {
    //Pone el botón del play en color verde.
    [self.playButton setImage:[UIImage imageNamed:@"BotonPlayVerde.png"] forState:UIControlStateNormal];
    //Apaga el botón pause y stop
    [self.pauseButton setImage:NO forState:UIControlStateNormal];
    [self.stopButton setImage:NO forState:UIControlStateNormal];
    
    //Animación
    float time = 1.00;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:time];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
    //Gira el brazo de la aguja
    CGAffineTransform moverAguja = self.imagenAguja.transform;
    moverAguja = CGAffineTransformMakeRotation(+0.4);
    self.imagenAguja.transform = moverAguja;
    
    [self startSpin];
    
    [UIView commitAnimations];
    
    
    
    /* Asignacion de los valores actuales del reproductor para que no se pierdan a la hora de reproducir la nueva instancia */
    panActualFloat = self.reproductor.pan;
    volumenActualFloat = self.reproductor.volume;
    rateActualFloat = self.reproductor.rate;
    
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
    //[self.reproductor prepareToPlay];
    
        
    
    
    //[UIView commitAnimations];
    
    //[self startSpin];
    
    /* tiempoQueTranscurre.text = [[NSString alloc] initWithFormat: @"%4.2f", self.reproductor.currentTime];
     
     tiempoTotal.text = [[NSString alloc] initWithFormat:@"%4.2f", self.reproductor.duration];
     barraProgreso = [[UIProgressView alloc] init];*/
    
    //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
    [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:time]];
    //Comienza a sonar la canción
    [self.reproductor play];
}

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
    [self.pauseButton setImage:[UIImage imageNamed:@"BotonPauseVerde.png"] forState:UIControlStateNormal];
    //Apaga el botón play y stop
    [self.playButton setImage:NO forState:UIControlStateNormal];
    [self.stopButton setImage:NO forState:UIControlStateNormal];
    
    
    /*etiqueta.text = [[NSString alloc] initWithFormat:@"duration: %4.2f \n currentTime %4.2f", self.reproductor.duration, self.reproductor.currentTime];*/
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.00];
    [UIView setAnimationBeginsFromCurrentState:YES];
    timeActualFloat = self.reproductor.currentTime;
    
    [self stopSpin];
    
    //etiqueta.text = 0;
    
    
    CGAffineTransform moverAguja = self.imagenAguja.transform;
    moverAguja = CGAffineTransformMakeRotation(-0.01);
    self.imagenAguja.transform = moverAguja;
    [UIView commitAnimations];
    [self.reproductor pause];
}

- (IBAction)Stop:(id)sender {
    //Pone el botón del stop en color verde.
    [self.stopButton setImage:[UIImage imageNamed:@"BotonStopVerde.png"] forState:UIControlStateNormal];
    //Apaga el botón play y pause
    [self.playButton setImage:NO forState:UIControlStateNormal];
    [self.pauseButton setImage:NO forState:UIControlStateNormal];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.00];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.reproductor.currentTime = 0;
    timeActualFloat = self.reproductor.currentTime;
    [self stopSpin];
    //etiqueta.text = 0;
    
    
    CGAffineTransform moverAguja = self.imagenAguja.transform;
    moverAguja = CGAffineTransformMakeRotation(-0.01);
    self.imagenAguja.transform = moverAguja;
    [UIView commitAnimations];
    
    
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
    [self setEtiqueta:nil];
    [self setTiempoQueTranscurre:nil];
    [self setTiempoTotal:nil];
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
