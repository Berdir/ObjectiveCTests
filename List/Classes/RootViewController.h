//
//  RootViewController.h
//  List
//
//  Created by ceesar on 16/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface RootViewController : UITableViewController <MBProgressHUDDelegate> {
    MBProgressHUD *HUD;
}

- (IBAction) update:(id) sender;


- (void)runUpdate;

@end
