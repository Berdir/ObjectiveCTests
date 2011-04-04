//
//  BrowserViewController.m
//  Browser
//
//  Created by ceesar on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"
#import "WebbrowserViewController.h"
#import "Importer.h"

@implementation RootViewController

@synthesize labellog =_labellog;

-(IBAction) startbrowser
{
    // testpunkt :UINavigationController* ctrl = self.navigationController;
    NSLog(@"button pressed");
    
    WebbrowserViewController* browser = [[WebbrowserViewController alloc] initWithNibName:@"WebbrowserViewController" bundle:[NSBundle mainBundle]];
	[self.navigationController pushViewController:browser animated:YES];
	[browser release];
	browser = nil;
}


-(void) fireTextLog:(NSNotification*) aNotification
{
    NSString* log = [aNotification object];
    NSString *line = [NSString stringWithFormat:@"%@\n%@", self.labellog.text, log];
    self.labellog.text = line;
    
}
-(IBAction)startParsing
{
    NSString *line = [NSString stringWithFormat:@"%@\n%@", self.labellog.text, @"Hallo"];
    self.labellog.text = line;
   
    Importer* parser = [[Importer alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fireTextLog:) 
                                                 name:@"xmlTagGefunden"
                                               object:nil];
    [parser parseXMLFile:nil];
    [parser release];
    parser = nil;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_labellog release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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

@end
