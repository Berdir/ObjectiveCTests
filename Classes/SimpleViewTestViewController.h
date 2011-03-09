//
//  SimpleViewTestViewController.h
//  SimpleViewTest
//
//  Created by ceesar on 07/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Counter.h"

#define kMinimumGestureLength 25
#define kMaximalVariance 5

@interface SimpleViewTestViewController : UIViewController {
	IBOutlet id textfield;
	Counter *_counter;
	CGPoint gestureStartPoint;
	bool counterIncreasedFlag;
}

-(IBAction) click:(id) sender; 
- (void) updateTextField;

@end

