//
//  pople.h
//  dicKeyValue
//
//  Created by YangBin on 12-12-6.
//  Copyright (c) 2012年 dacaiguoguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CFuctionFile.h"

@interface SYGPople : NSObject<NSCopying,NSCoding>
@property (nonatomic, copy) NSString *name;
@property int age;
@property int ID;
@property (nonatomic, copy)   NSString *pin;
@end


@interface SYGDataItemList : NSObject
@property (nonatomic, retain) NSMutableArray *dataArray;
+(SYGDataItemList*)shareSYGDataItemList;
- (void)addDataArrayObject:(SYGPople *)object;
- (void)removeDataArrayObject:(SYGPople *)object;
- (void)saveData;
@end

@interface SYGDataOperation : NSObject{
    SEL ArraySel[10];
    SYGDataItemList *_aShareList;
}
@property (nonatomic, retain) SYGDataItemList *aShareList;
+(SYGDataOperation*)shareSYGDataOperation;
- (void)creatAPople;
- (void)operationWith:(int)_operation;
- (void)showChoiceMessage;
- (void)deleteAPople;
- (void)deleteAPopleWithID:(int )_aID;
- (void)deleteAPopleWithPin:(NSString* )_aPin;
- (void)saveOperation;
@end