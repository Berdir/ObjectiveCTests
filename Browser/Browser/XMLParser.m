//
//  XMLParser.m
//  Browser
//
//  Created by ceesar on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "Action.h"
#import "Param.h"

#import <CoreData/CoreData.h>


@implementation XMLParser

NSString* keyCache = @"000"; //if you have nested tags -> this is the parent tag
NSMutableDictionary* managedObjectIDs; //cache all IDs for later linking entities


NSManagedObjectContext* context;



-(void)startParsing
{
    NSLog(@"parser started");
    //location of xml-file
    NSBundle *bundle = [NSBundle mainBundle];
	NSString* xmlfileName = [bundle pathForResource:@"xml-example" ofType:@"xml"];
    NSURL* xmlURL = [[NSURL fileURLWithPath:xmlfileName] retain];
    

    managedObjectIDs = [[NSMutableDictionary alloc]init]; 
    context = [[[UIApplication sharedApplication] delegate] managedObjectContext];
    

    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];

    
    [self printDB];
    

    [xmlParser release];
    [managedObjectIDs release]; 
    
}


//eine vorgegebene Methode, welche vom Parser aufgerufen wird
- (void)parser:(NSXMLParser *) parser didStartElement: (NSString *)elementName namespaceURI: (NSString *)namespaceURI
 qualifiedName: (NSString *)qName attributes: (NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"action"]) { [self addAction:attributeDict];}
    if ([elementName isEqualToString:@"param"]) { [self addParam:attributeDict];}
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"xmlTagGefunden" object:elementName];
    
    
}

-(void)addAction:(NSDictionary*) attrib
{

    Action*  a = [NSEntityDescription insertNewObjectForEntityForName:@"Action" inManagedObjectContext:context];  
    
    keyCache = [attrib objectForKey:@"id"]; //this information will be used by next child tag-method
    [managedObjectIDs setValue:[a objectID] forKey:keyCache];   //just mapping from xml-id to coreDB-IDs
    
    a.name = [attrib objectForKey:@"name"];

}

-(void)addParam:(NSDictionary*)attrib
{
    Action* a = (Action*)[context objectWithID:[managedObjectIDs valueForKey:keyCache]];//get parent-tag
    
    Param* p = [NSEntityDescription insertNewObjectForEntityForName:@"Param" inManagedObjectContext:context];    
    
    p.key = [attrib objectForKey:@"key"];
    p.value = [attrib objectForKey:@"value"];
    
    [a addParamsObject:p];
    
}

-(void)printDB
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Action" inManagedObjectContext:context];
 
    NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
    [request setEntity:entityDescription];
    
    NSError* error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    for (Action *a in result) {
        NSLog(@"Fetched Action %@", a.name);
        for (Param *p in a.params) {
            NSLog(@" - has Param key %@ and value %@", p.key, p.value);
        }
    }

}

- (void)deleteAllEntitiesInCoreData: (NSString *) entityDescription{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityDescription inManagedObjectContext:context];
    [fetchRequest setIncludesPropertyValues:NO];
	[fetchRequest setEntity:entity];
	
    NSError *error;
    NSArray *items = [context executeFetchRequest:fetchRequest error:&error];
    [fetchRequest release];
	
	
    for (NSManagedObject *managedObject in items) {
        [context deleteObject:managedObject];
    }
    if (![context save:&error]) {
		//Alert or Log
    }	
}




@end













/*
@implementation XMLElement

@synthesize tagName=_tagName;

NSDictionary* childTags;

-(void) initWithTagName:(NSString*) name
{
    [super init];
    _tagName = name;
}

-(NSMutableArray*)getChildren:(NSString*)tagName
{
    
}

-(void) addChild:(XMLElement*) tag
{
    [childTag 
}

@end
 */
