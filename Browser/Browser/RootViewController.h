//
//  BrowserViewController.h
//  Browser
//
//  Created by ceesar on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
    
    
}

@property(nonatomic, retain) IBOutlet UITextView* labellog;


-(IBAction) startbrowser;
-(IBAction) startParsing;


@end
