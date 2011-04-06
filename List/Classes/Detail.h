//
//  Detail.h
//  List
//
//  Created by ceesar on 16/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Detail : UIViewController {
	IBOutlet UILabel *label;
	IBOutlet UIButton *button;
    IBOutlet UIButton *imageButton;
    IBOutlet UILabel *actionLabel;
    
	CGPoint gestureStartPoint;
	
	NSString *selectedPresentation;
    
    int step;
    
    BOOL comfortImage;
    
    @private
        CGPoint imageInitialPoint;
}

- (IBAction) click: (id) sender;
- (IBAction) clickImage: (id) sender;
- (void) forward: (BOOL) animated;
- (void) backward;

@property (nonatomic, retain) NSString *selectedPresentation;
@property (nonatomic) int step;

@end
