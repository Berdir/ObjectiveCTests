//
//  Action.h
//  ERD
//
//  Created by ceesar on 22/03/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Action : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSSet* sequences;
@property (nonatomic, retain) NSSet* params;

@end
