//
//  ProgressMusicBar.h
//  tocadiscos
//
//  Created by Lion User on 05/11/12.
//  Copyright (c) 2012 LexyPlanet. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressMusicBar : UIProgressView


- (void)updateProgressBarWithTime:(NSTimeInterval)curentAudioTime andEnd:(NSTimeInterval) durationAudioTime;
@end
