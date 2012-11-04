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
	// Do any additional setup after loading the view.
    
    //[super viewDidLoad];
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
    
    //[super viewDidLoad];
    //[super viewDidLoad];
    
    
    
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
    
    
    
    
    
    //Hay una canción por defecto hasta que se use la selección.
    self.cancionActual = [[NSBundle mainBundle] pathForResource:@"Estopa. La primavera" ofType:@"mp3"];

    //SELECCIÓN NOMBRE CANCION
    self.etiqueta.text=@"Estopa. La primavera";
    //SELECCIÓN NOMBRE CANCION

    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:self.cancionActual];
    self.reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    
    self.reproductor.pan = 0;
    self.reproductor.volume = 0.5;
    
    self.reproductor.enableRate = YES;
    self.reproductor.rate = 1;
    [self.reproductor prepareToPlay];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Play:(id)sender {
    //Animación
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.00];
    [UIView setAnimationBeginsFromCurrentState:YES];
    
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
    
    /*BORRAR SI TODO VA BIEN
     Asignamos el nombre de la canción seleccionada en el PickerView, si esta es nula, 
     le ponemos la de por defecto.*/
/*    self.etiqueta.text=self.nombreCancionActual;
    if (self.etiqueta.text==nil) {
        self.etiqueta.text=@"Estopa. La primavera";
    }
 */   
    
    
    /* Se vuelve a ajustar la propiedad EnableRate a YES para que la nueva instancia realize el Rate
     ya que por default una nueva instancia tiene un valor de NO asi que si asignamos una nueva instancia de AVAudioPlayer
     y despues lo reproducimos, si queremos cambiar el rate éste no lo hará (que es lo que pasaba) */
    self.reproductor.enableRate = YES;
    
    self.reproductor.rate = rateActualFloat;
    self.reproductor.currentTime = timeActualFloat;
    [self.reproductor prepareToPlay];
    
    CGAffineTransform moverAguja = self.imagenAguja.transform;
    moverAguja = CGAffineTransformMakeRotation(+0.1);
    self.imagenAguja.transform = moverAguja;
    
    [UIView commitAnimations];
    
    [self startSpin];
    
    /* tiempoQueTranscurre.text = [[NSString alloc] initWithFormat: @"%4.2f", self.reproductor.currentTime];
     
     tiempoTotal.text = [[NSString alloc] initWithFormat:@"%4.2f", self.reproductor.duration];
     barraProgreso = [[UIProgressView alloc] init];*/
    
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
    /*etiqueta.text = [[NSString alloc] initWithFormat:@"duration: %4.2f \n currentTime %4.2f", self.reproductor.duration, self.reproductor.currentTime];*/
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.00];
    [UIView setAnimationBeginsFromCurrentState:YES];
    timeActualFloat = self.reproductor.currentTime;
    
    [self stopSpin];
    
    //etiqueta.text = 0;
    
    
    CGAffineTransform moverAguja = self.imagenAguja.transform;
    moverAguja = CGAffineTransformMakeRotation(-0.5);
    self.imagenAguja.transform = moverAguja;
    [UIView commitAnimations];
    [self.reproductor pause];
}

- (IBAction)Stop:(id)sender {
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.00];
    [UIView setAnimationBeginsFromCurrentState:YES];
    self.reproductor.currentTime = 0;
    timeActualFloat = self.reproductor.currentTime;
    [self stopSpin];
    //etiqueta.text = 0;
    
    
    CGAffineTransform moverAguja = self.imagenAguja.transform;
    moverAguja = CGAffineTransformMakeRotation(-0.5);
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

    //SELECCIÓN NOMBRE CANCION
- (void) nuevaCancionSeleccionada: (NSString *) cancionSelec{
    self.nombreCancionActual = cancionSelec;
    self.etiqueta.text=self.nombreCancionActual;

}
    //SELECCIÓN NOMBRE CANCION

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"goToCanciones"])
    {
        NuevaCancionViewController * nuevaCancionViewController = (NuevaCancionViewController *) segue.destinationViewController;
        nuevaCancionViewController.delegate = self;
        
    }
    
}

//HE CREADO ESTE IBACTION
- (IBAction)showMediaPicker:(id)sender {
    
    
    MPMediaPickerController *mediaPicker = [[MPMediaPickerController alloc] initWithMediaTypes: MPMediaTypeAny];
    
    mediaPicker.delegate = self;
    mediaPicker.allowsPickingMultipleItems = YES;
    mediaPicker.prompt = @"Select songs to play";
    
    [self presentModalViewController:mediaPicker animated:YES];
}

- (void) mediaPicker: (MPMediaPickerController *) mediaPicker didPickMediaItems: (MPMediaItemCollection *) mediaItemCollection
{
    if (mediaItemCollection) {
        
//        [reproductor setQueueWithItemCollection: mediaItemCollection];
//        [musicPlayer play];
    }
    
	[self dismissModalViewControllerAnimated: YES];
}


- (void) mediaPickerDidCancel: (MPMediaPickerController *) mediaPicker
{
	[self dismissModalViewControllerAnimated: YES];

}
//HE COPIADO HASTA AQUI y comentado lo de enmedio
//HE IMPORTADO EL FRAMEWORK AL .H y HE INCORPORADO EL FRAMEWORK AL PROYECTO

@end
