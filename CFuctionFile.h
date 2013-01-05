//
//  CFuctionFile.h
//  dicKeyValue
//
//  Created by YangBin on 12-12-7.
//  Copyright (c) 2012年 dacaiguoguo. All rights reserved.
//
#import <Foundation/Foundation.h>

#define projectDirWith(aFilename) [NSString stringWithFormat:@"%@%@",projectDir(),aFilename]
#define  KEY_FIRST @"firstP"
#define  KEY_SECOND @"second"
NSString *projectDir();
NSString *inputAStringLength(unsigned int _long,const char *_aString);
int  inputAInt(const char *_aString);
int scanfAtIntArray(char*_intString);