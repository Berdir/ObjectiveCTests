//
//  ZimmermannPlayerViewController.h
//  ZimmermannPlayer
//
//  Created by ceesar on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZimmermannPlayerViewController : UIViewController {

	UILabel* meldung;
}

@property (readwrite, retain) IBOutlet UILabel* meldung;
- (IBAction) filmAbspielen;
- (void) playerCallback: (NSNotification*) anObject;

@end

