//
//  GLMenuView.h
//  VDataProcess
//
//  Created by tony on 7/6/16.
//  Copyright © 2016 V. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GLMenuView : UIView

@property (nonatomic, assign) BOOL showSlider;


- (instancetype)initWithFrame:(CGRect)frame withMenuItem:(NSArray *)menuArr;

@end
