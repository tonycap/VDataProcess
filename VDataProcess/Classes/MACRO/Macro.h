//
//  Macro.h
//  DImageFilter
//
//  Created by tony on 6/23/16.
//  Copyright © 2016 sjtu. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height
#define Padding10   10
#define Padding20   20
#define padding30   30

typedef NS_ENUM(NSInteger, GrayFilterType) {
    GrayTypeDeal = 1001,  //灰度化
    GrayTypeHist = 1002,    //灰度直方图
    GrayTypeEqual = 1003,   //灰度均衡化
    GrayTypeHistEqual = 1004,   //直方图均衡化
    GrayTypeMap = 1005,    //灰度直方图
    GrayTypeErosion = 2101,    //二值腐蚀
    GrayTypeDilate = 2102,     //二值膨胀
    GrayTypeMorphologyOpen = 2103,       //二值开操作
    GrayTypeMorphologyClose = 2104,      //二值闭操作
};

typedef NS_ENUM(NSInteger, BinaryType) {
    BinaryTypeMaxEntropy = 2001,   //最大熵阈值
    BinaryTypeGlobal = 2002,   //全局阈值
    BinaryTypeDetech = 2003,   //迭代法
    BinaryTypeOTSU = 2004,   //迭代法
    BinaryTypeCustom = 2005,   //自定义阈值
};

typedef NS_ENUM(NSInteger, Morphologytype) {
    MorphologytypeErosion = 3001,  //腐蚀
    MorphologytypeDilate = 3002,   //膨胀
    MorphologytypeOpen = 3003, //开操作
    MorphologytypeClose = 3004,//闭操作
    MorphologytypeGradient = 3005,//梯度
    MorphologytypeTopHat = 3006,//顶帽
    MorphologytypeBlackHat = 3007,//黑帽
};

typedef NS_ENUM(NSInteger, EdgeType) {
    EdgeTypeSobel = 4001,
    EdgeTypeCanny = 4002,
    EdgeTypeLaplace = 4003,
    EdgeTypeScharr = 4004,
    EdgeTypeRoberts = 4005,
    EdgeTypePrewitt = 4006,
};

typedef NS_ENUM(NSInteger, SmoothType) {
    SmoothTypeBoxBlur = 5001,   //方框滤波
    SmoothTypeBlur = 5002,  //均值滤波
    SmoothTypeGussianBlur = 5003,  //高斯滤波
    SmoothTypeMedianBlur = 5004,   //中值滤波
    SmoothTypeBilatelBlur = 5005,  //双边滤波
};

typedef NS_ENUM(NSInteger, SkeletonType) {
    SkeletonTypeDistanceTransform = 6001,  //距离转换
    SkeletonTypeHilditch = 6002,
    SkeletonTypeRosenfeld = 6003,
    SkeletonTypeMorph = 6004,
};


#endif /* Macro_h */
