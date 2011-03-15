//
//  SimpleViewTestViewController.m
//  SimpleViewTest
//
//  Created by ceesar on 07/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SimpleViewTestViewController.h"

@implementation SimpleViewTestViewController




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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	_counter = [Counter new];
}



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

- (void)click: (id) sender {
	[_counter increase];
	[self updateTextField];	
}

- (void) updateTextField {
	[textfield setText:[NSString stringWithFormat:@"%d", [_counter getCount]]];
}

// Gesture stuff.
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	gestureStartPoint = [touch locationInView:self.view];
	counterIncreasedFlag = FALSE;
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	// Bail out if already updated counter.
	if (counterIncreasedFlag) {
		return;
	}
	
	
	UITouch *touch = [touches anyObject];
	CGPoint currentPosition = [touch locationInView: self.view];
	
	CGFloat deltaX = gestureStartPoint.x - currentPosition.x;
	
	if (fabs(deltaX) >= kMinimumGestureLength) {
		if (deltaX > 0) {
			[_counter decrease];
		} else {
			[_counter increase];
		}
		[self updateTextField];
		counterIncreasedFlag = TRUE;
		
	}
}
- (void)dealloc {
    [super dealloc];
}

@end
