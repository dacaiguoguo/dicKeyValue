//
//  main.m
//  dicKeyValue
//  $(TARGET_TEMP_DIR)/store1.plist
//  Created by YangBin on 12-12-6.
//  Copyright (c) 2012年 dacaiguoguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SYGPople.h"
#import "CFuctionFile.h"

void test();

int main(int argc, const char * argv[])
{

    @autoreleasepool {
//        test();
//        printf("\r      ");
        
        printf("\033[47;31mhello world\033[");
        
        SYGDataOperation *defultOper = [SYGDataOperation new];
        [defultOper showChoiceMessage];
        [defultOper release];
    }
    return 0;
}
void test(){

    SYGPople *aP1 = [[SYGPople alloc] init];
    aP1.name = @"name";
    aP1.age = 12;
    aP1.ID = 1;
    aP1.pin = @"spin";
    NSString *pp = projectDirWith(@"storeToday.plist");
    
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:[NSArray arrayWithObject:aP1] forKey:@"data"];
    [archiver finishEncoding];
    [data writeToFile:pp atomically:YES];
    [aP1 release];
    [archiver release];
    [data release];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:pp]) {
        NSMutableData *aData = [[NSMutableData alloc] initWithContentsOfFile:pp];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:aData];
        NSArray  *tmp = [unarchiver decodeObjectForKey:@"data"];
        NSLog(@"%@",tmp);
        NSNumber *tmpPeople  = [tmp objectAtIndex:0];
        NSLog(@"%@",[tmpPeople class]);
        [unarchiver release];
        [aData release];
    }
    
}


