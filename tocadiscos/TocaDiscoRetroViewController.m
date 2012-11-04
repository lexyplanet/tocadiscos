//
//  TocaDiscoRetroViewController.m
//  tocadiscos
//
//  Created by Beto on 04/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "TocaDiscoRetroViewController.h"

@interface TocaDiscoRetroViewController ()

@end

@implementation TocaDiscoRetroViewController

@synthesize _sliderVolumen;
@synthesize _sliderStereo;
@synthesize _sliderRate;
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
	// Do any additional setup after loading the view.
    
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
    //Inicializa el objeto de la clase BotonesRetro
    botonesRetro= [[BotonesRetro alloc]init];

    /*********************************************/

    [brazo anchorPointGiroBrazo:brazoAgujaImageView PosicionX:230 andPosicionY:38 andAnclajeX:0.5 andAnclajeY:0.26];
    
    [playerPicker iniciaReproductor:playButton andPauseButton:pauseButton andStopButton:stopButton];
    
    /******************************** INICIALIZACION DE VARIABLE DE STATUS DE PAUSE (ADRIAN) *********************/
    /*NSError * error;
    
    self.cancionActual = [[NSBundle mainBundle] pathForResource:@"dePeli" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:self.cancionActual];
    self.reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];*/
    pausado = NO;
    self.tiempoTotal.text=[playerPicker songTime];
    
}

- (IBAction)Play:(id)sender {
    
    //Animación
    float time = 1.00;
    [animacion inicioAnimacion:time];
    
    if(pausado){
        [brazo giroBrazo:brazoAgujaImageView andGradosGiro:0.0];
        [playerPicker playButton ];
        pausado=NO;
    }else{
    pausado=YES;
    /********* PEDRO 3/11/2012 *********/
    //Sonido clic
    [sonido setSonido:@"clic" andExtension:@"mp3"];
    //Introduce una pausa para que la aguja se coloque en su posición sobre el disco
    [retardo tiempoEspera:0.25];
    /*********************************/
    
    
    //Gira el brazo de la aguja
    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:0.4];
    
    //[self startSpin];
    [disco inicioGiro:discoImageView];
    
    [animacion finAnimacion];
    
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
    [playerPicker playButton];
    
    /******************************** VERSION ADRIAN PROGRESS BAR Y LABELS *********************/
    /*float duracionAudio = [self.reproductor duration];
    
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
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];*/
        
        //[playerPicker songCurrent:self.tiempoQueTranscurre];
    /******************************************************************************/
}
}

/******************************* ACTUALIZA PROGRESSBAR (ADRIAN) ************************************/
#pragma mark - UpdateProgressBar
/*- (void)updateProgressBar:(NSTimer *)timer
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
}*/


- (IBAction)Stop:(id)sender {
    //Pone el botón del stop en color verde.
    [animacion inicioAnimacion:1.0];
    [disco pararGiro];
    [brazo giroBrazo:brazoAgujaImageView andGradosGiro:-0.01];
    [animacion finAnimacion];
    [playerPicker stopButton];
}


- (IBAction)cambioVolumen:(id)sender {
    [playerPicker volumen: sender];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
