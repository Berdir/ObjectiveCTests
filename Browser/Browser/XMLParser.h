//
//  XMLParser.h
//  Browser
//
//  Created by ceesar on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface XMLParser : NSObject {
    
}

-(void)startParsing;

@end

@interface XMLElement : NSObject {
    
}

@property (readonly) NSString* tagName;

-(NSMutableArray*)getChildren:(NSString*)tagName;

@end


