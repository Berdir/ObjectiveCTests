//
//  Param.h
//  ERD
//
//  Created by ceesar on 23/03/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Action, LocalPicture;

@interface Param : NSManagedObject {
@private
}
@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) NSString * value;
@property (nonatomic, retain) Action * action;
@property (nonatomic, retain) LocalPicture * localImage;

@end
