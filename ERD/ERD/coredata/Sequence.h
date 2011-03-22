//
//  Sequence.h
//  ERD
//
//  Created by ceesar on 22/03/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, Presentation;

@interface Sequence : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * command;
@property (nonatomic, retain) NSSet* presentations;
@property (nonatomic, retain) NSSet* actions;

@end
