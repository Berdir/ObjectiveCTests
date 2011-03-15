//
//  ZimmermannPlayerAppDelegate.h
//  ZimmermannPlayer
//
//  Created by ceesar on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZimmermannPlayerViewController;

@interface ZimmermannPlayerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ZimmermannPlayerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ZimmermannPlayerViewController *viewController;

@end

