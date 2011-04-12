//
//  TestAppDelegate.m
//
//  Copyright iOSDeveloperTips.com All rights reserved.
//

#import "TestAppDelegate.h"
#import "TestViewController.h"

@implementation TestAppDelegate

@synthesize window, vc;

/*---------------------------------------------------------------------------
* 
*--------------------------------------------------------------------------*/
- (void)applicationDidFinishLaunching:(UIApplication *)application 
{   
  // Create and initialize the window
	window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

	// Create test view controller
	vc = [[TestViewController alloc] init];
  
	[window addSubview:vc.view];
  [window makeKeyAndVisible];
}

- (void)dealloc 
{
	[vc release];
  [window release];
  [super dealloc];
}

@end
