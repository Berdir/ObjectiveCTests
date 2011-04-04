//
//  Importer.m
//
//  Created by ceesar on 3/31/11. Markus Zimmermann
// This Class parses XML-Contents from Web or a local file (xml-example.xml, testpic.jpg)
//

#import "Importer.h"
#import "Config.h"
#import <CoreData/CoreData.h>
#import "Action.h" //all generated Entity-Classes
#import "Param.h"
#import "LocalPicture.h"
#import "Sequence.h"
#import "Presentation.h"


@implementation Importer


NSManagedObjectContext* context; //Entity manager
Config* configTag; //HelperClass to put Child-Tag Attributes to CoreDBFramework


//for debugging purposes
-(void)printDB
{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Presentation" inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init] ;
    [request setEntity:entityDescription];
    
    NSError* error = nil;
    NSArray *result = [context executeFetchRequest:request error:&error];
    
    
    for (Presentation *p in result) {
        NSLog(@"Presentation %@ contains:", p.name);

        for (Sequence* s in p.sequences)
        {
            NSLog(@"    a Sequence with name %@ contains Actions:", s.name);
            for (Action* a in s.actions)
            {
                NSLog(@"        Action %@ with:", a.name);
                for (Param* pa in a.params)
                {
                     NSLog(@"           Param key = %@ ", pa.key);
                     NSLog(@"           Param value = %@ ", pa.value);
                     NSLog(@"           Param Picture size = %i", [pa.localImage.picture length]);
                    
                }
            }
        }
            
    }
    
    
    
    [request release];
    
    
}

//flush all entities from coredata framework
-(void)clearDB
{
    NSArray* tableList =[[NSArray alloc]initWithObjects:@"Action",@"LocalPicture",@"Param",@"Presentation",@"Sequence", nil];
    
    for (NSString* table in tableList) {
        NSFetchRequest * fetch;
        @try {
             fetch = [[NSFetchRequest alloc] init];
            [fetch setEntity:[NSEntityDescription entityForName:table inManagedObjectContext:context]];
            NSArray * result = [context executeFetchRequest:fetch error:nil];
            for (id basket in result)
                [context deleteObject:basket];
        } @catch (NSException* ex){NSLog(@"Tabelle %@ nicht vorhanden",table);}
        @finally {
            [fetch release];
        }
    }
    
    [tableList release];
}

//the main entry of that class
-(void)parseXMLFile:(NSString*) fileName
{

    NSLog(@"parser started");
    context = [[[UIApplication sharedApplication] delegate] managedObjectContext];
    //location of xml-file
    NSURL* xmlURL;
    if (fileName == nil) {
        NSBundle *bundle = [NSBundle mainBundle];
        fileName = [bundle pathForResource:@"xml-example" ofType:@"xml"];
        xmlURL = [NSURL fileURLWithPath:fileName];
    }

    //TODO urlString from param to xmlURL-var
    
    
    [self clearDB];
    [self clearDB];
    
    configTag = [[Config alloc]init];
    
     NSXMLParser* xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [xmlParser setDelegate:self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    
    [configTag saveToDB];
    
    [self printDB];
    
    [configTag release];
    [xmlParser release];
}

//a delegate Callback invoked from NSXmlParser
- (void)parser:(NSXMLParser *) parser didStartElement: (NSString *)elementName namespaceURI: (NSString *)namespaceURI
 qualifiedName: (NSString *)qName attributes: (NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"action"]) { [configTag addAction:attributeDict];}
    if ([elementName isEqualToString:@"param"]) { [configTag addParam:attributeDict];}
    if ([elementName isEqualToString:@"sequence"]) { [configTag addSequence:attributeDict];}
    if ([elementName isEqualToString:@"actionRef"]) { [configTag addActionRef:attributeDict];}
    if ([elementName isEqualToString:@"presentation"]) { [configTag addPresentation:attributeDict];}
    if ([elementName isEqualToString:@"sequenceRef"]) { [configTag addSequenceRef:attributeDict];}
    if ([elementName isEqualToString:@"server"]) { [configTag addServer:attributeDict];}

    
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"xmlTagGefunden" object:elementName];
    
    
}

@end
