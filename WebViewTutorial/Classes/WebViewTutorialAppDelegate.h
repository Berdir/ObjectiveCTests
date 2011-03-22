//
//  WebViewTutorialAppDelegate.h
//  WebViewTutorial
//
//  Created by iPhone SDK Articles on 8/19/08.
//  Copyright www.iPhoneSDKArticles.com 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebViewTutorialViewController, WebViewController;

@interface WebViewTutorialAppDelegate : NSObject <UIApplicationDelegate> {
	IBOutlet UIWindow *window;
	WebViewController *wvTutorial;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) WebViewController *wvTutorial;

@end

