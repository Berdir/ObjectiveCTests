//
//  SynchTestViewController.m
//  SynchTest
//
//  Created by ceesar on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SynchTestViewController.h"

// The Bonjour application protocol, which must:
// 1) be no longer than 14 characters
// 2) contain only lower-case letters, digits, and hyphens
// 3) begin and end with lower-case letter or digit
// It should also be descriptive and human-readable
// See the following for more information:
// http://developer.apple.com/networking/bonjour/faq.html
#define kGameIdentifier		@"synctest"

@implementation SynchTestViewController

@synthesize bvc = _bvc;

@synthesize ownEntry = _ownEntry;
@synthesize showDisclosureIndicators = _showDisclosureIndicators;
@synthesize currentResolve = _currentResolve;
@synthesize netServiceBrowser = _netServiceBrowser;
@synthesize services = _services;
@synthesize needsActivityIndicator = _needsActivityIndicator;
@dynamic timer;
@synthesize initialWaitOver = _initialWaitOver;
@synthesize ownName = _ownName;


- (void)dealloc
{
    [_inStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[_inStream release];
    
	[_outStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
	[_outStream release];
    
	[_server release];
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
    [self setup];
}



- (void)setup {
    [_server release];
	_server = nil;
	
	[_inStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[_inStream release];
	_inStream = nil;
	_inReady = NO;
    
	[_outStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[_outStream release];
	_outStream = nil;
	_outReady = NO;
	
	_server = [TCPServer new];
	[_server setDelegate:self];
	NSError *error = nil;
	if(_server == nil || ![_server start:&error]) {
		if (error == nil) {
			NSLog(@"Failed creating server: Server instance is nil");
		} else {
            NSLog(@"Failed creating server: %@", error);
		}
		//[self _showAlert:@"Failed creating server"];
		return;
	}
	
	//Start advertising to clients, passing nil for the name to tell Bonjour to pick use default name
	if(![_server enableBonjourWithDomain:@"local" applicationProtocol:[TCPServer bonjourTypeFromIdentifier:kGameIdentifier] name:nil]) {
		//[self _showAlert:@"Failed advertising server"];
        statusLabel.text = @"Failed advertising server";
		return;
	}	
    statusLabel.text = @"Finished setup";
    
    NSString *type = [TCPServer bonjourTypeFromIdentifier:kGameIdentifier];
    [self searchForServicesOfType:type inDomain:@"local"];
}

// Creates an NSNetServiceBrowser that searches for services of a particular type in a particular domain.
// If a service is currently being resolved, stop resolving it and stop the service browser from
// discovering other services.
- (BOOL)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain {
	
	[self stopCurrentResolve];
	[self.netServiceBrowser stop];
	[self.services removeAllObjects];
    
	NSNetServiceBrowser *aNetServiceBrowser = [[NSNetServiceBrowser alloc] init];
	if(!aNetServiceBrowser) {
        // The NSNetServiceBrowser couldn't be allocated and initialized.
		return NO;
	}
    
	aNetServiceBrowser.delegate = self;
	self.netServiceBrowser = aNetServiceBrowser;
	[aNetServiceBrowser release];
	[self.netServiceBrowser searchForServicesOfType:type inDomain:domain];
    
	return YES;
}

- (void)stopCurrentResolve {
    
	[self.currentResolve stop];
	self.currentResolve = nil;
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didRemoveService:(NSNetService *)service moreComing:(BOOL)moreComing {
	// If a service went away, stop resolving it if it's currently being resolved,
	// remove it from the list and update the table view if no more events are queued.
    
    //statusLabel.text = @"Removed Service";
	
	if (self.currentResolve && [service isEqual:self.currentResolve]) {
		[self stopCurrentResolve];
	}
	[self.services removeObject:service];
	if (self.ownEntry == service)
		self.ownEntry = nil;
	
	// If moreComing is NO, it means that there are no more messages in the queue from the Bonjour daemon, so we should update the UI.
	// When moreComing is set, we don't update the UI so that it doesn't 'flash'.
	if (!moreComing) {
		//[self sortAndUpdateUI];
	}
}	

- (void)netServiceBrowser:(NSNetServiceBrowser *)netServiceBrowser didFindService:(NSNetService *)service moreComing:(BOOL)moreComing {
	// If a service came online, add it to the list and update the table view if no more events are queued.
	if ([service.name isEqual:self.ownName]) {
		self.ownEntry = service;
    } else {
        
        // If another resolve was running, stop it & remove the activity indicator from that cell
        if (self.currentResolve) {
            // Stop the current resolve, which will also set self.needsActivityIndicator
            [self stopCurrentResolve];
        }
        
        // Then set the current resolve to the service corresponding to the tapped cell
        self.currentResolve = service;
        [self.currentResolve setDelegate:self];
        
        // Attempt to resolve the service. A value of 0.0 sets an unlimited time to resolve it. The user can
        // choose to cancel the resolve by selecting another service in the table view.
        [self.currentResolve resolveWithTimeout:0.0];
        
        statusLabel.text = [NSString stringWithFormat: @"Connecting to %@", service.name];
    }
}	

// This should never be called, since we resolve with a timeout of 0.0, which means indefinite
- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict {
	[self stopCurrentResolve];
}

- (void)netServiceDidResolveAddress:(NSNetService *)service {
	assert(service == self.currentResolve);
	
	[service retain];
	[self stopCurrentResolve];
    
    
	// note the following method returns _inStream and _outStream with a retain count that the caller must eventually release
	if (![service getInputStream:&_inStream outputStream:&_outStream]) {
		statusLabel.text = @"Failed connecting to server";
		return;
	}
    
    
    statusLabel.text = [NSString stringWithFormat: @"Connected with %@!", service.name];
    
	[self openStreams];
	
	[service release];
}

- (void) send:(const uint8_t)message
{
	if (_outStream && [_outStream hasSpaceAvailable]) {
		if([_outStream write:(const uint8_t *)&message maxLength:sizeof(const uint8_t)] == -1) {
			//[self _showAlert:@"Failed sending data to peer"];
        }
    }
}

- (void) openStreams
{
	_inStream.delegate = self;
	[_inStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[_inStream open];
	_outStream.delegate = self;
	[_outStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
	[_outStream open];
    
    statusLabel.text = @"Ready!";
}

- (void) browserViewController:(BrowserViewController *)bvc didResolveInstance:(NSNetService *)netService
{
	if (!netService) {
		[self setup];
		return;
	}
    
	// note the following method returns _inStream and _outStream with a retain count that the caller must eventually release
	if (![netService getInputStream:&_inStream outputStream:&_outStream]) {
		statusLabel.text = @"Failed connecting to server";
		return;
	}
    
    statusLabel.text = @"Connected to peer";
    
	[self openStreams];
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

- (IBAction) up:(id)sender {
    valueLabel.text = [NSString stringWithFormat:@"%d", [valueLabel.text intValue] + 1];
    [self send:1];
}

- (IBAction) down: (id)sender {
    valueLabel.text = [NSString stringWithFormat:@"%d", [valueLabel.text intValue] - 1];
    [self send:-1];
}

@end


#pragma mark -
@implementation SynchTestViewController (NSStreamDelegate)

- (void) stream:(NSStream *)stream handleEvent:(NSStreamEvent)eventCode
{
	switch(eventCode) {
		case NSStreamEventOpenCompleted:
		{
			
			[_server release];
			_server = nil;
            
			if (stream == _inStream)
				_inReady = YES;
			else
				_outReady = YES;
			
			if (_inReady && _outReady) {
                statusLabel.text = @"Connected";
			}
			break;
		}
		case NSStreamEventHasBytesAvailable:
		{
			if (stream == _inStream) {
				uint8_t b;
				int len = 0;
				len = [_inStream read:&b maxLength:sizeof(uint8_t)];
				if(len <= 0) {
					if ([stream streamStatus] != NSStreamStatusAtEnd)
						statusLabel.text = @"Failed reading data from peer";
				} else {
					statusLabel.text = [NSString stringWithFormat: @"Got data: %s", b];
                    valueLabel.text = [NSString stringWithFormat:@"%d", [valueLabel.text intValue] + b];
                    
				}
			}
			break;
		}
		case NSStreamEventErrorOccurred:
		{
			NSLog(@"%s", _cmd);
			statusLabel.text = @"Error encountered on stream!";			
			break;
		}
			
		case NSStreamEventEndEncountered:
		{
				
			NSLog(@"%s", _cmd);
			
			statusLabel.text = @"Peer Disconnected!";
            	
			break;
		}
	}
}

@end

#pragma mark -
@implementation SynchTestViewController (TCPServerDelegate)

- (void) serverDidEnableBonjour:(TCPServer *)server withName:(NSString *)string
{
	NSLog(@"%s", _cmd);
    self.ownName = string;
    statusLabel.text = [NSString stringWithFormat:@"Enabled (%@)", string];
}

- (void)didAcceptConnectionForServer:(TCPServer *)server inputStream:(NSInputStream *)istr outputStream:(NSOutputStream *)ostr
{
	if (_inStream || _outStream || server != _server)
		return;
	
	[_server release];
	_server = nil;
	
	_inStream = istr;
	[_inStream retain];
	_outStream = ostr;
	[_outStream retain];
    
    statusLabel.text = @"Was connected.";
	
	[self openStreams];
}

@end


