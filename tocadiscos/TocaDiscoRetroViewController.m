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
    /*********************************************/

    [brazo anchorPointGiroBrazo:brazoAgujaImageView PosicionX:190 andPosicionY:4 andAnclajeX:0.5 andAnclajeY:0.26];
    
    [playerPicker iniciaReproductor:playButton andPauseButton:pauseButton andStopButton:stopButton];
    
    /******************************** INICIALIZACION DE VARIABLE DE STATUS DE PAUSE (ADRIAN) *********************/
    pausado = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
