//
//  SynchTestViewController.h
//  SynchTest
//
//  Created by ceesar on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TCPServer.h"
#import "BrowserViewController.h"

@interface SynchTestViewController : UIViewController <TCPServerDelegate, NSStreamDelegate, BrowserViewControllerDelegate, NSNetServiceDelegate, NSNetServiceBrowserDelegate> {
    IBOutlet UILabel *valueLabel;
    IBOutlet UIButton *upButton;
    IBOutlet UIButton *downButton;
    
    IBOutlet UILabel *statusLabel;
    
	TCPServer			*_server;
	NSInputStream		*_inStream;
	NSOutputStream		*_outStream;
	BOOL				_inReady;
	BOOL				_outReady;
    
	NSNetService *_ownEntry;
	BOOL _showDisclosureIndicators;
	NSMutableArray *_services;
	NSNetServiceBrowser *_netServiceBrowser;
	NSNetService *_currentResolve;
	NSTimer *_timer;
	BOOL _needsActivityIndicator;
	BOOL _initialWaitOver;
    
    NSString *_ownName;
    
    
    @private 
        BrowserViewController *_bvc;
    
}

@property (nonatomic, retain, readwrite) BrowserViewController *bvc;
@property (nonatomic, retain, readwrite) NSNetService *ownEntry;
@property (nonatomic, assign, readwrite) BOOL showDisclosureIndicators;
@property (nonatomic, retain, readwrite) NSMutableArray *services;
@property (nonatomic, retain, readwrite) NSNetServiceBrowser *netServiceBrowser;
@property (nonatomic, retain, readwrite) NSNetService *currentResolve;
@property (nonatomic, retain, readwrite) NSTimer *timer;
@property (nonatomic, assign, readwrite) BOOL needsActivityIndicator;
@property (nonatomic, assign, readwrite) BOOL initialWaitOver;
@property (nonatomic, assign, readwrite) NSString *ownName;


- (IBAction) up: (id) sender;
- (IBAction) down: (id) sender;
- (void) setup;
- (void) stopCurrentResolve;
- (BOOL)searchForServicesOfType:(NSString *)type inDomain:(NSString *)domain;

@end
