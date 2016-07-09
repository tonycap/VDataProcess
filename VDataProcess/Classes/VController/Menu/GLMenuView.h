//
//  GLMenuView.h
//  VDataProcess
//
//  Created by tony on 7/6/16.
//  Copyright © 2016 V. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GLMenuViewDelegate <NSObject>

- (void)itemInfoChange:(id)itemInfo sliderValue:(NSInteger)value;

@end


@interface GLMenuView : UIView

@property (nonatomic, assign) id<GLMenuViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame withMenuItem:(NSArray *)menuArr;

- (void)itemSelectAtIndex:(NSInteger)index;
@end
