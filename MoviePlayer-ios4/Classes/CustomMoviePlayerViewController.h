//
//  CustomMoviePlayerViewController.h
//
//  Copyright iOSDeveloperTips.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface CustomMoviePlayerViewController : UIViewController 
{
  MPMoviePlayerController *mp;
  NSURL 									*movieURL;
    
    UIButton *button;
}

- (id)initWithPath:(NSString *)moviePath;
- (void)readyPlayer;
- (void) close: (id) sender;

@end
