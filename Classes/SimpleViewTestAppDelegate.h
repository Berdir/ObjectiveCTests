//
//  SimpleViewTestAppDelegate.h
//  SimpleViewTest
//
//  Created by ceesar on 07/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleViewTestViewController;

@interface SimpleViewTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SimpleViewTestViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SimpleViewTestViewController *viewController;

@end

