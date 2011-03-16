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
	
	NSString *selectedPresentation;
}

- (void)click: (id) sender;

@property (nonatomic, retain) NSString *selectedPresentation;

@end
