//
//  ZimmermannPlayerViewController.m
//  ZimmermannPlayer
//
//  Created by ceesar on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZimmermannPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@implementation ZimmermannPlayerViewController

int _count = 1;
@synthesize meldung;



- (IBAction) filmAbspielen
{
	//NSBundle *bundle = [NSBundle mainBundle];
	//NSString* fileName = [bundle pathForResource:@"kungfupigeon5" ofType:@"mov"];
	//NSURL* movieURL = [[NSURL fileURLWithPath:fileName] retain];
	
	NSURL* movieURL = [NSURL URLWithString:@"http://user.enterpriselab.ch/~tazimmer/kungfupigeon5.mov"];
	MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];

	//listener zum loggen einrichtren
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerCallback) name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie.moviePlayer];
	
	theMovie.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;	
	[self presentMoviePlayerViewControllerAnimated: theMovie];
	[theMovie.moviePlayer play];
	
	
	//MPMoviePlayerController* theMovie = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    //theMovie.scalingMode = MPMovieScalingModeAspectFill;
	//[theMovie play];
	
		
	//[theMovie release];
		
		

	

}

- (void) playerCallback: (NSNotification*) anObject
{
	//[self dealloc];
	//++_count;
	
	//self.meldung.text = [NSString stringWithFormat:@"%@%i",@"Fertig",_count];
	
	//MPMoviePlayerController *player = (MPMoviePlayerController *)[anObject object];
	//[player stop];
	
	// Remove notifications
	//[[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
	
	// Release the movie instance created in playMovieAtURL:
	//player.movieControlMode = MPMovieControlModeHidden;
	//[player release];
	
	
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
