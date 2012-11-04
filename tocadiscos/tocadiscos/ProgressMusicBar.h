//
//  ProgressMusicBar.h
//  tocadiscos
//
//  Created by Adrian de Jesus Piedra Goicochea on 03/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressMusicBar : UIProgressView


- (void)updateProgressBarWithTime:(NSTimeInterval)curentAudioTime andEnd:(NSTimeInterval) durationAudioTime;
@end
