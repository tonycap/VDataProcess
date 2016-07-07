//
//  GLMenuView.m
//  VDataProcess
//
//  Created by tony on 7/6/16.
//  Copyright © 2016 V. All rights reserved.
//

#import "GLMenuView.h"

#import "ASValueTrackingSlider.h"
#import "GLMenuItem.h"
#import "Macro.h"

@interface GLMenuView ()<ASValueTrackingSliderDelegate, GLMenuItemDelegate>{
    int sliderValue;
}

@property (nonatomic, strong) ASValueTrackingSlider *slider;

@property (nonatomic, strong) UIScrollView *menuScrollView;

@property (nonatomic, strong) NSArray *itemArr;
@property (nonatomic, strong) id selectItem;

@end

@implementation GLMenuView


- (instancetype)initWithFrame:(CGRect)frame withMenuItem:(NSArray *)menuArr{
    if (self = [super initWithFrame:frame]) {
        _showSlider = TRUE;
        [self refreshMenuWithSlider: self.showSlider];
        [self contentInitWithMenuArr:menuArr];
    }
    
    return self;
}

const int menuWidth = 100;

- (void)refreshMenuWithSlider:(BOOL)flag{
    sliderValue = 0;
    
    self.backgroundColor = [UIColor whiteColor];
    if (flag) {
        self.slider = [[ASValueTrackingSlider alloc] initWithFrame:CGRectMake(Padding20, Padding10, ScreenWidth - 2*Padding20, 20)];
        self.slider.maximumValue = 100;
        [self.slider setMaxFractionDigitsDisplayed:0];
        self.slider.delegate = self;
        self.slider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
        self.slider.popUpViewAnimatedColors = @[[UIColor purpleColor], [UIColor redColor], [UIColor orangeColor]];
        [self addSubview:self.slider];
    }else{
        [self.slider removeFromSuperview];
    }
    
    self.menuScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 60, ScreenWidth, 60)];
    [self addSubview:self.menuScrollView];
}

- (void)contentInitWithMenuArr:(NSArray *)arr{
    if (arr.count <= 0) {
        return;
    }
    
    self.itemArr = arr;
    for (UIView *subView in self.menuScrollView.subviews) {
        [subView removeFromSuperview];
    }
    
    for (int i=0; i< arr.count; i++) {
        NSDictionary *itemDic = [arr objectAtIndex:i];
        NSString *imgName = [itemDic objectForKey:@"image"];
        NSString *titleStr = [itemDic objectForKey:@"title"];
        UIImage *menuImg = [UIImage imageNamed:(imgName.length > 0 ? imgName : @"icon_menu")];
        GLMenuItem *item = [[GLMenuItem alloc] initWithFrame:CGRectMake(i*menuWidth, 0, menuWidth, CGRectGetHeight(self.menuScrollView.bounds)) withImage:menuImg title:titleStr];
        item.itemInfo = itemDic;
        item.delegate = self;
        [self.menuScrollView addSubview:item];
    }
    
    self.menuScrollView.contentSize = CGSizeMake(menuWidth * arr.count, CGRectGetHeight(self.menuScrollView.bounds));
    self.menuScrollView.contentOffset = CGPointZero;
}

#pragma mark -- GLMenuItemDelegate
- (void)menuItemSelect:(id)itemInfo{
    for (UIView *view in self.menuScrollView.subviews) {
        if ([view isKindOfClass:[GLMenuItem class]]) {
            GLMenuItem *item = (GLMenuItem *)view;
            if (item.itemInfo == itemInfo) {
                item.selected = true;
            }else{
               item.selected = false;
            }
        }
    }
    self.selectItem = itemInfo;
    sliderValue = ((sliderValue != 0) ? sliderValue : 0);
    
    [self updateItemInfo:itemInfo sliderValue:sliderValue];
    
}

#pragma mark ---
- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider{
    NSLog(@"sliderWillDisplayPopUpView");
}

- (void)sliderDidHidePopUpView:(ASValueTrackingSlider *)slider{
    sliderValue = [@(slider.value) intValue];
    if (self.selectItem) {
        [self updateItemInfo:self.selectItem sliderValue:sliderValue];
    }
}

#pragma mark -- update Item Info
- (void)updateItemInfo:(id)itemInfo sliderValue:(NSInteger)value{
    if (self.delegate && [self.delegate respondsToSelector:@selector(itemInfoChange:sliderValue:)]) {
        [self.delegate itemInfoChange:itemInfo sliderValue:value];
    }
}

@end
