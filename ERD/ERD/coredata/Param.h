//
//  Param.h
//  ERD
//
//  Created by ceesar on 22/03/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action;

@interface Param : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Action * action;

@end
