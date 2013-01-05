//
//  CFuctionFile.m
//  dicKeyValue
//
//  Created by YangBin on 12-12-7.
//  Copyright (c) 2012年 dacaiguoguo. All rights reserved.
//
#include <stdio.h>
NSString *projectDir(){
    NSString *myDic = [NSString stringWithFormat:@"%s",__FILE__];
    NSArray *dicArray = [myDic componentsSeparatedByString:@"/"];
    NSString *lastFileName = [dicArray lastObject];
    NSRange range;
    range.location = 0;
    range.length = myDic.length-lastFileName.length;
    NSString *subStr = [myDic substringWithRange:range];
    return subStr;
}

NSString *inputAStringLength(unsigned int _long,const char *_aString){
    char tmp[100];
    memset(tmp, 0, sizeof(char)*100);
    printf("%s:",_aString);
    scanf("%s",tmp);
    NSString *tmpStr = [NSString stringWithCString:tmp encoding:NSUTF8StringEncoding];
    
    int tmpLong = (int)tmpStr.length;
    _long = MIN(tmpLong,_long);
    return [NSMutableString stringWithString:[tmpStr substringToIndex:_long]];;
}


int  inputAInt(const char *_aString){
    char a[100];
    memset(a, 0, sizeof(char)*100);

    printf("%s:",_aString);
    scanf("%s",a);
    NSString *tmpStr = [NSString stringWithCString:a encoding:NSUTF8StringEncoding];
    return [tmpStr intValue];
}


int* scanfAtIntArray(char*_intString,char *_component){
    assert(_component);
    assert(_intString);

    NSString *spString = [NSString stringWithCString:_intString encoding:NSUTF8StringEncoding];
    NSArray *spArray = [spString componentsSeparatedByString:[NSString stringWithCString:_component encoding:NSUTF8StringEncoding]];
    
    int *ret = (int *)malloc(sizeof(int)*spArray.count);
    [spArray enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop) {
        ret[idx] = obj.intValue;
    }];
    return ret;
}
