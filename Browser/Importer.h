//
//  Importer.h
//  Browser
//
//  Created by ceesar on 3/31/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Importer : NSObject <NSXMLParserDelegate>{
    
}

-(void)parseXMLFile:(NSString*) fileName;

@end
