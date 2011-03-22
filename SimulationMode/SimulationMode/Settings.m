//
//  Settings.m
//  SimulationMode
//
//  Created by ceesar on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"


@implementation Settings

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    prefs = [NSUserDefaults standardUserDefaults];
    // Do any additional setup after loading the view from its nib.
    
    BOOL simMode = [prefs boolForKey:@"SimulationMode"];
    if (simMode) {
        simSwitch.on = simMode;
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction) simChange: (id) sender {
    
    [prefs setBool:simSwitch.on forKey:@"SimulationMode"];
    
    if (simSwitch.on == YES) {
        self.navigationController.navigationBar.tintColor = [UIColor redColor];
    }
    else {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];

    }
}

@end
