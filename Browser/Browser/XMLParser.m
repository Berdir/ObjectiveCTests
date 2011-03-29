//
//  XMLParser.m
//  Browser
//
//  Created by ceesar on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
//#import <CoreData/CoreData.h>


@implementation XMLParser


XMLElement* rootelement;

-(void)startParsing
{
    NSLog(@"parser started");
    //location of xml-file
    NSBundle *bundle = [NSBundle mainBundle];
	NSString* xmlfileName = [bundle pathForResource:@"xml-example" ofType:@"xml"];
    NSURL* xmlURL = [[NSURL fileURLWithPath:xmlfileName] retain];
    


    NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    

    [xmlParser release];
    
}


//eine vorgegebene Methode, welche vom Parser aufgerufen wird
- (void)parser:(NSXMLParser *) parser didStartElement: (NSString *)elementName namespaceURI: (NSString *)namespaceURI
 qualifiedName: (NSString *)qName attributes: (NSDictionary *)attributeDict
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"xmlTagGefunden" object:elementName];
    
    
}

@end

@implementation XMLElement

@synthesize tagName=_tagName;

-(void) initWithTagName:(NSString*) name
{
    [super init];
    _tagName = name;
}

-(NSMutableArray*)getChildren:(NSString*)tagName
{
    
}

@end
