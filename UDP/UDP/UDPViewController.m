//
//  UDPViewController.m
//  UDP
//
//  Created by ceesar on 16/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "UDPViewController.h"

@implementation UDPViewController

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


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    _udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
    [_udpSocket bindToPort:4321 error:nil];
}

- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port {
    NSString *response = [NSString stringWithCString:[data bytes] encoding:NSASCIIStringEncoding];
    NSString *line = [NSString stringWithFormat:@"Got '%@' from %@:%i\n", response, host, port];
    labellog.text = [labellog.text stringByAppendingString:line];
    return TRUE;
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

- (IBAction) send:(id)sender {
    NSData *data = [labelcommand.text dataUsingEncoding: NSASCIIStringEncoding];

    [_udpSocket sendData:data toHost:labelip.text port:[labelport.text intValue] withTimeout:-1 tag:1];
    [_udpSocket receiveWithTimeout:10 tag:1];
}

@end
