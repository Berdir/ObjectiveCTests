//
//  Counter.h
//  SimpleViewTest
//
//  Created by ceesar on 07/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Counter : NSObject {
  @private
	int clickCount;
}

- init;
-(void) increase;
-(void) decrease;
-(int) getCount;

@end
