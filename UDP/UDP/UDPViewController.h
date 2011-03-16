//
//  UDPViewController.h
//  UDP
//
//  Created by ceesar on 16/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncUdpSocket.h"

@interface UDPViewController : UIViewController <AsyncUdpSocketDelegate> {
    //Instance for sending UDP packages over the network
    AsyncUdpSocket *_udpSocket;
    IBOutlet UITextField *labelip;
    IBOutlet UITextField *labelport;
    IBOutlet UITextField *labelcommand;
    IBOutlet UITextView *labellog;
}

- (IBAction) send: (id) sender;
- (BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port;

@end
