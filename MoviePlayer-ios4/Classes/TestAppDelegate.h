//
//  TestAppDelegate.h
//
//  Copyright iOSDeveloperTips.com All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestViewController;

@interface TestAppDelegate : NSObject <UIApplicationDelegate>
{
  UIWindow *window;
  TestViewController *vc;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) TestViewController *vc;

@end

