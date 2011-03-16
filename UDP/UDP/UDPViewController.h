//
//  UDPViewController.h
//  UDP
//
//  Created by ceesar on 16/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncUdpSocket.h"

@interface UDPViewController : UIViewController {
    //Instance for sending UDP packages over the network
    AsyncUdpSocket *_udpSocket;
    IBOutlet UITextField *ip;
    IBOutlet UITextField *port;
    IBOutlet UITextField *command;
    IBOutlet UITextView *log;
}

- (IBAction) send: (id) sender;

@end
