//
//  XMLParser.m
//
//  Created by Markus Zimmermann 3/28/11. 
// This Class is used to handle events called from Importer Class. The methods decides how to persist
// contents (Attributes) from the actual XML Tag into coreFramework. The order of calling the methods
// is VERY VERY VERY important for correct xml-parsing
//

#import "Config.h"
#import "Action.h"
#import "Param.h"
#import "LocalPicture.h"
#import "Sequence.h"
#import "Presentation.h"

#import <CoreData/CoreData.h>


@implementation Config

NSString* keyCache = @"000"; //the xml-ID of the actual parent-Tag at runtime when parser iterates top-down the xml-file. 
NSMutableDictionary* managedObjectIDs; //maps all xml-ID's to ID's of Coredata-Entities

NSManagedObjectContext* context;


-(id)init
{
    id i = [super init];
    managedObjectIDs = [[NSMutableDictionary alloc]init]; 
    context =  [[[UIApplication sharedApplication] delegate] managedObjectContext];
    return i;
}

-(void)dealloc{
    [managedObjectIDs release];
    [super dealloc];
}


//loads a picture from local or internet and put it into core database
-(LocalPicture * )loadPicture:(NSString*)url
{
    //NSString* url = @"http://www.die-seite.ch/movie.gif";
    //NSString* url = @"testpic.jpg";
    NSURL* picURL;
    NSData *data; //the picture binariers
    
    if ([url hasPrefix:@"http"]) //load from I-Net
    {
        picURL = [NSURL URLWithString:url]; 
        NSMutableURLRequest  *theRequest=[NSMutableURLRequest 
                                          requestWithURL:picURL
                                          cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:2.0];
   
        data = [NSURLConnection sendSynchronousRequest:theRequest
                                           returningResponse:nil error:nil];
        
        
    } else  //then load from local file
    {
        NSBundle* bundle = [NSBundle mainBundle];
        NSString* rootdir = [bundle resourcePath];
        NSString* fileName = [NSString stringWithFormat:@"%@/%@",rootdir,url];
        picURL = [NSURL fileURLWithPath:fileName];
        data = [[NSFileManager defaultManager] contentsAtPath:fileName];
        
    }
    
    //NSLog(@" länge = %i", [data length]);
    
    //create a Coredata Object and fill with data
    LocalPicture*  lp = [NSEntityDescription insertNewObjectForEntityForName:@"LocalPicture" inManagedObjectContext:context]; 
    lp.picture = data;
    
    return lp;

}


//analyzes action tag and put attributes into the core database
-(void)addAction:(NSDictionary*) attrib
{

    Action*  a = [NSEntityDescription insertNewObjectForEntityForName:@"Action" inManagedObjectContext:context];  
    
    keyCache = [attrib objectForKey:@"id"]; //this information will be used by next child tag-method
    [managedObjectIDs setValue:[a objectID] forKey:keyCache];// dito
    
    a.name = [attrib objectForKey:@"name"];
    

}

//analyzes param tag and put attributes into the core database
-(void)addParam:(NSDictionary*)attrib
{
    Action* a = (Action*)[context objectWithID:[managedObjectIDs valueForKey:keyCache]];//get parent-tag
    
    Param* p = [NSEntityDescription insertNewObjectForEntityForName:@"Param" inManagedObjectContext:context];    
    
    p.key = [attrib objectForKey:@"key"];
    p.value = [attrib objectForKey:@"value"];

    [a addParamsObject:p]; //calling of a generated code.. (fill the 1:n-collection)
    
    //Put a pic into db if needed
    if ([p.key hasPrefix:@"localPicture"]) {
        
        LocalPicture*  lp = [self loadPicture:p.value]; 
        p.localImage = lp;

    }
    
}


//analyzes sequence tag and put attributes into the core database
-(void) addSequence:(NSDictionary *)attrib
{

    Sequence*  s = [NSEntityDescription insertNewObjectForEntityForName:@"Sequence" inManagedObjectContext:context];  
    
    keyCache = [attrib objectForKey:@"id"]; //this information will be used by next child tag-method
    [managedObjectIDs setValue:[s objectID] forKey:keyCache];// dito
    
    s.name = [attrib objectForKey:@"name"];
    s.command =[attrib objectForKey:@"command"];
    NSString* icon = [attrib objectForKey:@"icon"];
    
    //put a picture into db if needed
    if (![icon isEqual:@""])
    {
        LocalPicture*  lp  = [self loadPicture:icon];
        s.icon = lp;
    }    
}

//links an Action Reference (childtag) to the actual Sequence (parent tag)
- (void)addActionRef:(NSDictionary *)attrib
{
    Sequence* s = (Sequence*)[context objectWithID:[managedObjectIDs valueForKey:keyCache]];//get parent-tag
 
    //get an Action from dbPool
    NSString* actionRef = [attrib objectForKey:@"ref"];
    Action* a = (Action*)[context objectWithID:[managedObjectIDs valueForKey:actionRef]];
    
    [s addActionsObject:a]; //calling of a generated code.. (fill the 1:n-collection)
    
}

//analyzes presentation tag and put attributes into the core database
-(void) addPresentation:(NSDictionary *)attrib
{

    Presentation*  s = [NSEntityDescription insertNewObjectForEntityForName:@"Presentation" inManagedObjectContext:context];  
    
    keyCache = [attrib objectForKey:@"id"]; //this information will be used by next child tag-method
    [managedObjectIDs setValue:[s objectID] forKey:keyCache];// dito
    
    s.name = [attrib objectForKey:@"name"];
    s.comment =[attrib objectForKey:@"comment"];
    
}

//links an Sequence Reference (childtag) to the actual Presentation (parent tag)
-(void) addSequenceRef:(NSDictionary *)attrib
{
    Presentation* p = (Presentation*)[context objectWithID:[managedObjectIDs valueForKey:keyCache]];//get parent-tag
    
    //get an Action from dbPool
    NSString* sequenceRef = [attrib objectForKey:@"ref"];
    Sequence* s = (Sequence*)[context objectWithID:[managedObjectIDs valueForKey:sequenceRef]];
    
    [p addSequencesObject:s]; //calling of a generated code.. (fill the 1:n-collection)
    
}
//puts NSUserdefaults from the xml
-(void) addServer:(NSDictionary *)attrib
{

    NSString* type = [attrib objectForKey:@"type"];
    
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
	if (standardUserDefaults) {
		[standardUserDefaults setObject:attrib forKey:type];
		[standardUserDefaults synchronize];
	}

    
}

-(void) saveToDB
{
    NSError* err = nil;
    [context save:&err];
    if (err!=nil) {
        NSLog([err localizedDescription]);
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
