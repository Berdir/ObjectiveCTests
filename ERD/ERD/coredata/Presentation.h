//
//  Presentation.h
//  ERD
//
//  Created by ceesar on 22/03/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Presentation : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSSet* sequences;

- (void)addSequencesObject:(NSManagedObject *)value;

@end
