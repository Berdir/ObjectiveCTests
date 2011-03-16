    //
//  Detail.m
//  List
//
//  Created by ceesar on 16/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Detail.h"


@implementation Detail

@synthesize selectedPresentation;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	label.text = selectedPresentation;
	self.navigationItem.title = @"Selected Presentation";
    self.navigationController.toolbar.hidden = TRUE;
    self.navigationController.navigationBar.tintColor = [UIColor redColor];
    //self.navigationController.navigationBar.hidden = TRUE;
    
}

- (void)click: (id) sender {
    self.navigationController.toolbar.hidden = FALSE;
    //self.navigationController.navigationBar.hidden = FALSE;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];
    [[self navigationController] popViewControllerAnimated:YES];	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[label release];
    [super dealloc];
}


@end
