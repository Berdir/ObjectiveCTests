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
#import <QuartzCore/QuartzCore.h>

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
    
    NSString *imageName;
    NSString *title;
    NSString *sequence;

    switch (step) {
        case 1:
            imageName = @"01_init.png";
            title = @"iHomeLab initalisieren";
            sequence = @"Einführung";
            break;
        case 2:
            imageName = @"02_lamellen.png";
            title = @"Lamellen bewegen";
            sequence = @"Einführung";
            break;
        case 3:
            imageName = @"03_lisa.png";
            title = @"Begrüssung Lisa";
            sequence = @"Einführung";
            break;
        case 4:
            imageName = @"04_garage.png";
            title = @"Garagetor öffnen";
            sequence = @"Lounge";
            break;
        case 5:
            imageName = @"05_lounge.png";
            title = @"Loungetüre öffnen";
            sequence = @"Lounge";
            break;
        case 6:
            imageName = @"06_show.png";
            title = @"Basispräsentation starten";
            sequence = @"Lounge";
            break;
        case 7:
            imageName = @"07_lab.png";
            title = @"Labtüre öffnen";
            sequence = @"Showcases";
            break;
        case 8:
            imageName = @"08_komfort.png";
            title = @"Showcase Komfort starten";
            sequence = @"Showcases";
            break;
        case 9:
            imageName = @"09_aal.png";
            title = @"Showcase AAL starten";
            sequence = @"Showcases";
            break;
        case 10:
            imageName = @"10_energie.png";
            title = @"Showcase Energieeffizienz starten";
            sequence = @"Showcases";
            break;
            
        default:
            imageName = @"TODO";
            title = @"TODO";
            break;
    }
    [imageButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
	
	label.text = [sequence uppercaseString];
    actionLabel.text = title;
    
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
            self.navigationController.navigationBar.hidden = FALSE;
            [[self navigationController] popViewControllerAnimated:YES];
            direction = @"down";
            break;
        case UISwipeGestureRecognizerDirectionUp:
        {	
            Favorites *fav = [[Favorites alloc] initWithNibName:@"Favorites" bundle:[NSBundle mainBundle]];
            [UIView beginAnimations: @"moveField" context: nil];
            
            [UIView setAnimationDelegate: self];
            
            [UIView setAnimationDuration:	1.5];
            
            // For left to right transition animation
            [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.navigationController.view	 cache:NO];	
            
            [self.navigationController pushViewController:fav animated:NO];
            
            [UIView commitAnimations];
            
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
    nextPage.step = self.step % 10 + 1;
    
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
    
    Detail *nextPage = [[Detail alloc] initWithNibName:@"Detail" bundle:[NSBundle mainBundle]];
    nextPage.selectedPresentation = self.selectedPresentation;
    self.step--;
    if (self.step <= 0) {
        self.step = 10;
    }
    nextPage.step = self.step;
    
    // Save NavigationController locally, to still have access to it in the second step.
    UINavigationController *navController = self.navigationController;
    
    // retain this viewcontroller, prevent dealloc.
    [[self retain] autorelease];
    
	[UIView beginAnimations: @"moveField" context: nil];
    	
	[UIView setAnimationDelegate: self];
    	
	[UIView setAnimationDuration:	.5];
    
    // For left to right transition animation
	//[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:navController.view	 cache:NO];	
    
    //self.view.transform = CGAffineTransformMakeTranslation(-320,0);
    nextPage.view.transform = CGAffineTransformMakeTranslation(320,0);
	
    // Pop the current controller and replace with another.
    [navController popViewControllerAnimated:NO];
    
    [navController pushViewController:nextPage animated:NO];
    
    [UIView commitAnimations];
    
    
}


- (void)dealloc {
	[label release];
    [super dealloc];
}


@end
