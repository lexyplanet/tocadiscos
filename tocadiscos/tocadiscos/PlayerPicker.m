//
//  PlayerPicker.m
//  tocadiscos
//
//  Created by Lion User on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "PlayerPicker.h"

@implementation PlayerPicker

@synthesize reproductor;
@synthesize cancionActual;

- (void) iniciaReproductor: (UIButton*)nuevoPlayButton
            andPauseButton: (UIButton*)nuevoPauseButton
             andStopButton: (UIButton*)nuevoStopButton
{
    NSError * error;
    
    cancionActual = [[NSBundle mainBundle] pathForResource:@"dePeli" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:cancionActual];
    reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    
    reproductor.pan = 0;
    reproductor.volume = 0.5;
    
    reproductor.enableRate = YES;
    reproductor.rate = 1;
    
    [reproductor prepareToPlay];
    
    //Se oculta las imagenes asignadas a los botones del tocadiscos (play, pause, stop)
    botonPlay = [[BotonesRetro alloc] init];
    botonPause = [[BotonesRetro alloc] init];
    botonStop = [[BotonesRetro alloc] init];
    
    //[botonPlay apagarPlay:nuevoPlayButton];
    //[botonPause apagarPause:nuevoPauseButton];
    //[botonStop apagarStop:nuevoStopButton];
}

-(void) playButton{
    [reproductor play];
}

-(void) stopButton{
    reproductor.currentTime=0;
    [reproductor stop];
}

-(void) nextButton:(id)sender{
    
}

-(void) forwardButton:(id)sender{
    
}

-(void) volumen:(id)sender{
    reproductor.volume = ((UISlider *) sender).value;    
}

-(NSString*) songTime{
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
        return [NSString stringWithFormat:@"%0.0f:0%0.0f", minutos, segundos];
    } else {
        //Ajuste del Label del tiempo transcurrido
        return [NSString stringWithFormat:@"%0.0f:%0.0f", minutos, segundos];
    }
    
    /*self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];*/
    /******************************************************************************/
}

-(void) songCurrentTime: (UILabel*)tiempoQueTranscurre
{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressBar:tiempoQueTranscurre:) userInfo:nil repeats:YES];
}

/******************************* ACTUALIZA PROGRESSBAR (ADRIAN) ************************************/
#pragma mark - UpdateProgressBar
- (void)updateProgressBar:(NSTimer *)timer tiempoQueTranscurre:(UILabel*)tiempoQueTranscurre
{
    NSTimeInterval tiempoDelAudio = [self.reproductor currentTime];     //Tiempo actual del audio
    NSTimeInterval duracionTotalDelAudio = [self.reproductor duration]; //Tiempo total del audio
    float progreso = tiempoDelAudio / duracionTotalDelAudio;            //Progreso de la cancion
    //[barraProgreso setProgress: progreso];                          //Ajusta el componente al progreso calculado
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
        tiempoQueTranscurre.text = [NSString stringWithFormat:@"%0.0f:0%0.0f", minutos, segundos];
    } else {
        //Ajuste del Label del tiempo transcurrido
        tiempoQueTranscurre.text = [NSString stringWithFormat:@"%0.0f:%0.0f", minutos, segundos];
    }
}

@end
