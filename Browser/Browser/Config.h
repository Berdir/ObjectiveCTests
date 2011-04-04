//
//  XMLParser.h
//  Browser
//
//  Created by ceesar on 3/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Config : NSObject {
    
}

-(void)addAction:(NSDictionary*)attrib;
-(void)addParam:(NSDictionary*)attrib;
-(void)addSequence:(NSDictionary*)attrib;
-(void)addActionRef:(NSDictionary*)attrib;
-(void)addPresentation:(NSDictionary*)attrib;
-(void)addSequenceRef:(NSDictionary*)attrib;
-(void)addServer:(NSDictionary*)attrib;
-(void)saveToDB;

@end







