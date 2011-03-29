//
//  BrowserAppDelegate.h
//  Browser
//
//  Created by ceesar on 3/25/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface BrowserAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet RootViewController *viewController;

@property (nonatomic, retain) IBOutlet UINavigationController* navCTRL;

@end
