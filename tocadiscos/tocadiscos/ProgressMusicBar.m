//
//  ProgressMusicBar.m
//  tocadiscos
//
//  Created by Lion User on 05/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import "ProgressMusicBar.h"

@implementation ProgressMusicBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setProgress:0.0];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code
        //[self setProgress:0.0];
    }
    return self;
}

#pragma mark - UpdateProgressBar
- (void)updateProgressBarWithTime:(NSTimeInterval)curentAudioTime andEnd:(NSTimeInterval) durationAudioTime
{
    float progreso = curentAudioTime/durationAudioTime;     //Progreso de la cancion
    [self setProgress: progreso];                           //Ajusta el componente al progreso calculado
    NSLog(@"%f", self.progress);
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
