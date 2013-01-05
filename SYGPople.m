//
//  pople.m
//  dicKeyValue
//
//  Created by YangBin on 12-12-6.
//  Copyright (c) 2012年 dacaiguoguo. All rights reserved.
//

#import "SYGPople.h"


@implementation SYGPople
@synthesize name;
@synthesize age;
@synthesize ID;
@synthesize pin;
- (id)copyWithZone:(NSZone *)zone{
    SYGPople *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [[self.name copyWithZone:zone] autorelease];
    copy.age = age;
    copy.ID = ID;
    copy.pin = [[self.pin copyWithZone:zone] autorelease];
    return copy;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"name:%@ age:%d ID:%d pin:%@",name,age,ID,pin];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:name forKey:@"name"];
    [aCoder encodeInt:age forKey:@"age"];
    [aCoder encodeInt:ID forKey:@"ID"];
    [aCoder encodeObject:pin forKey:@"pin"];
    
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.age = [aDecoder decodeIntForKey:@"age"];
        self.ID = [aDecoder decodeIntForKey:@"ID"];
        self.pin = [aDecoder decodeObjectForKey:@"pin"];
    }
    return self;
}

@end

@implementation SYGDataItemList
@synthesize dataArray = _dataArray;
- (void)dealloc{
    [super dealloc];
    [_dataArray release];
}
static SYGDataItemList* shareList = nil;
+(SYGDataItemList*)shareSYGDataItemList{
    @synchronized(self){
        if (shareList==nil) {
            shareList = [[[SYGDataItemList alloc] init] autorelease];
        }
    }
    return shareList;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (shareList==nil) {
            shareList = [super allocWithZone:zone];
            return shareList;
        }
    }
    return nil;
}
- (id)init{
    self = [super init];
    
    if (self) {
        NSString *path1=  projectDirWith(@"storeToday.plist");
        if ([[NSFileManager defaultManager] fileExistsAtPath:path1]) {
            NSMutableData *aData = [[NSMutableData alloc] initWithContentsOfFile:path1];
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:aData];
            NSArray  *tmp = [unarchiver decodeObjectForKey:@"data"];
            [unarchiver release];
            [aData release];
            self.dataArray = [NSMutableArray arrayWithArray:tmp];
        }else{
            self.dataArray = [NSMutableArray array];
        }
    }
    return self;
}


- (void)addDataArrayObject:(SYGPople *)object{

    [_dataArray addObject:object];
}

- (void)removeDataArrayObject:(SYGPople *)object{
    [_dataArray removeObject:object];
}

- (void)saveData{
    NSString *path1=  projectDirWith(@"storeToday.plist");
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.dataArray forKey:@"data"];
    [archiver finishEncoding];
    [data writeToFile:path1 atomically:YES];
    [archiver release];
    [data release];
}
@end



@implementation SYGDataOperation
@synthesize aShareList = _aShareList;
- (void)dealloc{
    [super dealloc];
    [_aShareList release];
}
static SYGDataOperation* dataOper = nil;
+(SYGDataOperation*)shareSYGDataOperation{
    @synchronized(self){
        if (dataOper==nil) {
            dataOper = [[[SYGDataOperation alloc] init] autorelease];
        }
    }
    return dataOper;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (dataOper==nil) {
            dataOper = [super allocWithZone:zone];
            return dataOper;
        }
    }
    return nil;
}

- (id)init{
    self = [super init];
    if (self) {
        for (int i=0; i<10; i++) {
            ArraySel[i] = NULL;
        }
        ArraySel[1] = @selector(creatAPople);
        ArraySel[2] = @selector(deleteAPople);
        ArraySel[3] = @selector(saveOperation);
        ArraySel[4] = @selector(printData);
        self.aShareList = [SYGDataItemList shareSYGDataItemList];
    }
    return self;
}

- (void)printData{
    NSLog(@"%@",self.aShareList.dataArray);
    [self showChoiceMessage];
    
//    [[self.aShareList dataArray] enumerateObjectsUsingBlock:^(SYGPople* obj, NSUInteger idx, BOOL *stop) {
//        NSLog(@"%@",obj);
//    }];
}
- (void)showChoiceMessage{
    printf("*********************************************\n************************************************\n");
    printf(" Well come to here ,help by print F1\n 创建按1，删除按2,，保存操作到文件按3，打印当前数据库按4，返回输入77\n");
    [self operationWith:inputAInt("请输入")];
}


- (void)creatAPople{
    SYGPople *aP = [SYGPople new];
    aP.name = inputAStringLength(10,"请输入名字");
    
   
    
    int i=0;
    __block BOOL alreadyexsit = NO;

    do{
        alreadyexsit = NO;
        if (i==0) {
            aP.ID = inputAInt("请输入ID");
        }else{
            aP.ID = inputAInt("ID重复啦，请重新输入ID");
        }
        [[self.aShareList dataArray] enumerateObjectsUsingBlock:^(SYGPople* obj, NSUInteger idx, BOOL *stop) {
            if (obj.ID==aP.ID) {
                alreadyexsit = YES;
                *stop = YES;
            }
        }];
        i++;
    }while (alreadyexsit==YES);
    
    aP.age = inputAInt("请输入年龄");
    
    __block BOOL alreadyexsitpin = NO;
    i=0;
    do{
        alreadyexsitpin = NO;
        if (i==0) {
            aP.pin = inputAStringLength(10,"请输入pin");
        }else{
            aP.pin = inputAStringLength(10, "pin重复啦，请重新输入pin");
        }
        
        [[self.aShareList dataArray] enumerateObjectsUsingBlock:^(SYGPople* obj, NSUInteger idx, BOOL *stop) {
            if ([obj.pin isEqualToString:aP.pin]) {
                alreadyexsitpin = YES;
                *stop = YES;
            }
        }];
        i++;
    }while(alreadyexsitpin==YES);
    
//    NSLog(@"%@",aP);
    
    [self.aShareList addDataArrayObject:aP];
    [aP release];
    [self showChoiceMessage];
}

- (void)deleteAPople{
    int a = inputAInt("按ID删除按1，按Pin删除按2");
    switch (a) {
        case 1:
        {
            int aID = inputAInt("请输入要删除的人的ID");
            [self deleteAPopleWithID:aID];
        }
            break;
        case 2:{
            NSString *tmpStr = inputAStringLength(10, "请输入要删除人的Pin");
            [self deleteAPopleWithPin:tmpStr];
            
        }
            break;
            
        default:{
            printf("Error");
            assert(0);
        }
            break;
    }
}
- (void)deleteAPopleWithID:(int )_aID{

    [[self.aShareList dataArray] enumerateObjectsUsingBlock:^(SYGPople* obj, NSUInteger idx, BOOL *stop) {
        if (obj.ID==_aID) {
            [self.aShareList removeDataArrayObject:obj];
            *stop = YES;
        }
    }];
}
- (void)deleteAPopleWithPin:(NSString* )_aPin{
    [[self.aShareList dataArray] enumerateObjectsUsingBlock:^(SYGPople* obj, NSUInteger idx, BOOL *stop) {
        if (obj.pin==_aPin) {
            [self.aShareList removeDataArrayObject:obj];
            *stop = YES;
        }
    }];
}



- (void)operationWith:(int)_operation{
//    assert(ArraySel[_operation]!=NULL);
    if (_operation==77) {
        return;
    }
    _operation = MIN(9, _operation);
    _operation = MAX(0, _operation);
    if (ArraySel[_operation]!=NULL) {
        [self performSelector:ArraySel[_operation]];
    }else{
        printf("操作Error\n");
        [self showChoiceMessage];
        return;
    }

}

- (void)saveOperation{
    [self.aShareList saveData];
    printf("文件保存成功！\n");
    printf( "\033[H\033[2J" );

    [self showChoiceMessage];
}

@end
