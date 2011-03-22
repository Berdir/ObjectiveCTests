//
//  ERDExample.m
//  ERD
//
//  Created by ceesar on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ERDExample.h"
#import "Presentation.h"
#import "Sequence.h"


@implementation ERDExample

@synthesize managedObjectContext = managedObjectContext;

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
    // Do any additional setup after loading the view from its nib.
    
    Presentation *newPresentation = [NSEntityDescription insertNewObjectForEntityForName:@"Presentation" inManagedObjectContext:self.managedObjectContext];
    
    newPresentation.name = @"A presentation";
    newPresentation.comment = @"Justa test presentation";
    
    Sequence *newSequence = [NSEntityDescription insertNewObjectForEntityForName:@"Sequence" inManagedObjectContext:self.managedObjectContext];
    
    newSequence.name = @"A test sequence";
    newSequence.command = @"LAB_START_INTRO";
    
    [newPresentation addSequencesObject:newSequence];
     
    NSError *error;
    [self.managedObjectContext save:&error];
    
    // Fetch entities.
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Presentation" inManagedObjectContext:self.managedObjectContext];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];
    
    NSArray *result = [self.managedObjectContext executeFetchRequest:request error:&error];
    for (Presentation *p in result) {
        NSLog(@"Fetched presentation %@", p.name);
        for (Sequence *s in p.sequences) {
            NSLog(@" - has Sequence %@", s.name);
        }
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

@end
