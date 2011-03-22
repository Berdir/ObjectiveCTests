//
//  Settings.h
//  SimulationMode
//
//  Created by ceesar on 22/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Settings : UIViewController {
    IBOutlet UISwitch *simSwitch;
    NSUserDefaults *prefs;
}

- (IBAction) simChange: (id) sender;

@end
