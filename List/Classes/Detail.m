    //
//  Detail.m
//  List
//
//  Created by ceesar on 16/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Detail.h"
#import <AudioToolbox/AudioServices.h>
#import "Favorites.h"



@implementation Detail

@synthesize selectedPresentation;
@synthesize step = step;

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
    
    if (step % 2) {
        [imageButton setImage:[UIImage imageNamed:@"lounge.jpg"] forState:UIControlStateNormal];
    } else {
        [imageButton setImage:[UIImage imageNamed:@"comfort.jpg"] forState:UIControlStateNormal];
    }
    
    imageInitialPoint = imageButton.frame.origin;
	
	label.text = selectedPresentation;
    actionLabel.text = [NSString stringWithFormat:@"Action %d", self.step];
    
	//self.navigationItem.title = @"Selected Presentation";
    self.navigationController.toolbar.hidden = TRUE;
    //self.navigationController.navigationBar.tintColor = [UIColor redColor];
    self.navigationController.navigationBar.hidden = TRUE;
    
    UISwipeGestureRecognizer *recognicer;
    
    recognicer = [[UISwipeGestureRecognizer alloc] initWithTarget: self action:@selector(handleSwipeFrom:)];
    [recognicer setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:recognicer];
    [recognicer release];
    
    recognicer = [[UISwipeGestureRecognizer alloc] initWithTarget: self action:@selector(handleSwipeFrom:)];
    [recognicer setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:recognicer];
    [recognicer release];
    
    recognicer = [[UISwipeGestureRecognizer alloc] initWithTarget: self action:@selector(handleSwipeFrom:)];
    [recognicer setDirection:UISwipeGestureRecognizerDirectionUp];
    [[self view] addGestureRecognizer:recognicer];
    [recognicer release];
    
    recognicer = [[UISwipeGestureRecognizer alloc] initWithTarget: self action:@selector(handleSwipeFrom:)];
    [recognicer setDirection:UISwipeGestureRecognizerDirectionDown];
    [[self view] addGestureRecognizer:recognicer];
    [recognicer release];
    [super viewDidLoad];
    
}

- (void) handleSwipeFrom: (UISwipeGestureRecognizer *) recogniser {
    NSString *direction;	
    switch (recogniser.direction) {
        case UISwipeGestureRecognizerDirectionDown:
            self.navigationController.toolbar.hidden = FALSE;
            [[self navigationController] popViewControllerAnimated:YES];
            direction = @"down";
            break;
        case UISwipeGestureRecognizerDirectionUp:
        {
            Favorites *fav = [[Favorites alloc] initWithNibName:@"Favorites" bundle:[NSBundle mainBundle]];
            [self.navigationController pushViewController:fav animated:YES];
            [fav release];
            fav = nil;
            direction = @"up";
        }
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self backward];		
            direction = @"right";
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            [self forward:TRUE];
            direction = @"left";
            break;
            
        default:
            direction = @"undefined";	
            break;
    }
    
    
    NSLog(@"Swipe direction '%@' received.", direction);	
}

- (void)click: (id) sender {
    self.navigationController.toolbar.hidden = FALSE;
    //self.navigationController.navigationBar.hidden = FALSE;
    
    //self.navigationController.navigationBar.tintColor = [UIColor colorWithHue:0.6 saturation:0.33 brightness:0.69 alpha:0];
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

- (void)clickImage:(id)sender {
    [self forward:false];
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate); 
}

- (void) forward:(BOOL) animated {
    NSString *controllerName = @"Detail";
    Detail *nextPage = [[NSClassFromString(controllerName) alloc] initWithNibName:controllerName bundle:[NSBundle mainBundle]];
    nextPage.selectedPresentation = self.selectedPresentation;
    nextPage.step = self.step + 1;
    
    // Save NavigationController locally, to still have access to it in the second step.
    UINavigationController *navController = self.navigationController;
    
    // retain this viewcontroller, prevent dealloc.
    [[self retain] autorelease];
    
    // Pop the current controller and replace with another.
    [navController popViewControllerAnimated:NO];
    [navController pushViewController:nextPage animated:animated];
}

- (void) backward {
    // Init animation
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.50];
    
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view cache:YES];
    
    Detail *nextPage = [[Detail alloc] initWithNibName:@"Detail" bundle:[NSBundle mainBundle]];
    nextPage.selectedPresentation = self.selectedPresentation;
    nextPage.step = self.step - 1;
    
    // Save NavigationController locally, to still have access to it in the second step.
    UINavigationController *navController = self.navigationController;
    
    // retain this viewcontroller, prevent dealloc.
    [[self retain] autorelease];
    
    
    // Pop the current controller and replace with another.
    [navController popViewControllerAnimated:NO];
    [navController pushViewController:nextPage animated:NO];
}


- (void)dealloc {
	[label release];
    [super dealloc];
}


@end
