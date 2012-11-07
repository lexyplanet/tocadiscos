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

- (void) iniciaReproductor: (Boton*)playButton
            andPauseButton: (Boton*)pauseButton
             andStopButton: (Boton*)stopButton
          andNombreCancion: (NSString*)cancion;
{
    nuevaCancionlPicker = [[NuevaCancionViewController alloc] init];
    /*NSError * error;
    
    cancionActual = [[NSBundle mainBundle] pathForResource:@"el tiempo se nos va" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:cancionActual];
    reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];*/
    
    [self nuevaCancionReproductor:cancion];
    
    reproductor.pan = 0;
    reproductor.volume = 0.5;
    
    reproductor.enableRate = YES;
    reproductor.rate = 1;
    
    [reproductor prepareToPlay];
    
    //Oculta las imagenes asignadas a los botones del tocadiscos (play, pause, stop)
    [playButton apagar];
    [pauseButton apagar];
    [stopButton apagar];
}

-(BOOL) verificaCancionActual
{
    
    //Controlar el error de no seleccionar ninguna canción en el picker
    if ([[nuevaCancionlPicker getCancionSeleccionada] isEqualToString:[nuevaCancionlPicker getCancion0]]) {
        SeleccionAlertView *error = [[SeleccionAlertView alloc] init];
        [error seleccionCancion];
        return NO;
    }
    else
    {
        return YES;
    }
}

-(void) playButton;
{
    /* Se vuelve a ajustar la propiedad EnableRate a YES para que la nueva instancia realize el Rate
     ya que por default una nueva instancia tiene un valor de NO asi que si asignamos una nueva instancia de AVAudioPlayer
     y despues lo reproducimos, si queremos cambiar el rate éste no lo hará (que es lo que pasaba) */
    reproductor.enableRate = YES;
    
    
    [reproductor play];
}

-(void) pauseButton
{
    [reproductor pause];
}

-(void) stopButton
{
    reproductor.currentTime=0;
    [reproductor stop];
}

-(void) volumen:(id)sender
{
    reproductor.volume = ((TocadiscosSlider *) sender).value;
}

-(void) pan:(id)sender
{
    reproductor.pan = ((TocadiscosSlider *) sender).value;
}
-(void) rate:(id)sender
{
    if ( (((TocadiscosSlider *) sender).value>0.6) && (((TocadiscosSlider *) sender).value<1.4) ) {
        reproductor.rate = 1;
    }
    else
    {
        reproductor.rate = ((TocadiscosSlider *) sender).value;
    }
}


//-(NSString*) songTime
//{
    /******************************** VERSION ADRIAN PROGRESS BAR Y LABELS *********************/
    //float duracionAudio = [self.reproductor duration];
    
    //Obteniendo los minutos
    //float minutos = floor(duracionAudio/60);
    //Obteniendo los segundos del audio restando los minutos que lleva
    //float segundos = duracionAudio - (minutos*60);
    
    //Inserta el tiempo total de la cancion.
    //Si los segundos son menores a 10 formatea el numero a mostrar
    
    //Ajuste del Label del tiempo transcurrido
    //return [NSString stringWithFormat:@"%0.0f:%0.0f", minutos, segundos];
    
    /*self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressBar:) userInfo:nil repeats:YES];*/
    /******************************************************************************/
//}

/**/

/*-(void) songCurrentTime: (UILabel*)tiempoQueTranscurre
{
    [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateProgressBar:tiempoQueTranscurre:) userInfo:nil repeats:YES];
}*/

/******************************* ACTUALIZA PROGRESSBAR (ADRIAN) ************************************/
#pragma mark - UpdateProgressBar
//- (void)updateProgressBar:(NSTimer *)timer
//      tiempoQueTranscurre:(UILabel*)tiempoQueTranscurre//
//{
    //NSTimeInterval tiempoDelAudio = [self.reproductor currentTime];     //Tiempo actual del audio
    //NSTimeInterval duracionTotalDelAudio = [self.reproductor duration]; //Tiempo total del audio
    //float progreso = tiempoDelAudio / duracionTotalDelAudio;            //Progreso de la cancion
    //[barraProgreso setProgress: progreso];
    //Ajusta el componente al progreso calculado
    
    //Obteniendo los minutos
    //float minutos = floor(tiempoDelAudio/60);
    //Obteniendo los segundos del audio restando los minutos que lleva
    //float segundos = tiempoDelAudio - (minutos*60);
    
    //Evita que en el label aparezca el seg 60
    //if(segundos > 59)
    //{
    //    segundos = 0.0;
    //    minutos += 1;
    //}
    
    //Si los segundos son menores a 10 formatea el numero a mostrar
    
    //Ajuste del Label del tiempo transcurrido
    //tiempoQueTranscurre.text = [NSString stringWithFormat:@"%0.0f:0%0.0f", minutos, segundos];
//}

/*Adrian: Invoqué el metodo IBAction ya definido ya que contiene toda la animacion y play de la cancion*/
#pragma mark - nuevaCanción Piker
- (void) nuevaCancionReproductor: (NSString*)nombreCancion
{
    //nuevaCancionlPicker = [[NuevaCancionViewController alloc] init];
    NSError * error;
    
    cancionActual = [[NSBundle mainBundle] pathForResource:nombreCancion ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:cancionActual];
    reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
}



@end
