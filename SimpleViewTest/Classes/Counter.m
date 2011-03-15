//
//  Counter.m
//  SimpleViewTest
//
//  Created by ceesar on 07/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
	
#import "Counter.h"


@implementation Counter
- init
{
	if (self = [super init]) {
		clickCount = 0;
	}
	return self;
}

- (void) increase
{
	clickCount++;
}

- (void) decrease
{
	clickCount--;
}
- (int) getCount
{
	return clickCount;
}

@end
