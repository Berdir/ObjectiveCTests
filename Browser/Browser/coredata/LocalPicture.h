//
//  LocalPicture.h
//  ERD
//
//  Created by ceesar on 23/03/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Param, Sequence;

@interface LocalPicture : NSManagedObject {
@private
}
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) Param * param;
@property (nonatomic, retain) Sequence * sequence;

@end
