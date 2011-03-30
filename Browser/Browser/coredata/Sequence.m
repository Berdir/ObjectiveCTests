//
//  Sequence.m
//  ERD
//
//  Created by ceesar on 23/03/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Sequence.h"
#import "Action.h"
#import "LocalPicture.h"
#import "Presentation.h"


@implementation Sequence
@dynamic name;
@dynamic command;
@dynamic presentations;
@dynamic actions;
@dynamic icon;

- (void)addPresentationsObject:(Presentation *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"presentations" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"presentations"] addObject:value];
    [self didChangeValueForKey:@"presentations" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removePresentationsObject:(Presentation *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"presentations" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"presentations"] removeObject:value];
    [self didChangeValueForKey:@"presentations" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addPresentations:(NSSet *)value {    
    [self willChangeValueForKey:@"presentations" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"presentations"] unionSet:value];
    [self didChangeValueForKey:@"presentations" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removePresentations:(NSSet *)value {
    [self willChangeValueForKey:@"presentations" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"presentations"] minusSet:value];
    [self didChangeValueForKey:@"presentations" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}


- (void)addActionsObject:(Action *)value {    
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"actions"] addObject:value];
    [self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)removeActionsObject:(Action *)value {
    NSSet *changedObjects = [[NSSet alloc] initWithObjects:&value count:1];
    [self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [[self primitiveValueForKey:@"actions"] removeObject:value];
    [self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:changedObjects];
    [changedObjects release];
}

- (void)addActions:(NSSet *)value {    
    [self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"actions"] unionSet:value];
    [self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueUnionSetMutation usingObjects:value];
}

- (void)removeActions:(NSSet *)value {
    [self willChangeValueForKey:@"actions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
    [[self primitiveValueForKey:@"actions"] minusSet:value];
    [self didChangeValueForKey:@"actions" withSetMutation:NSKeyValueMinusSetMutation usingObjects:value];
}



@end
