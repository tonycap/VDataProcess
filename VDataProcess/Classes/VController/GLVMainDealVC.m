//
//  GLVMainDealVC.m
//  DImageFilter
//
//  Created by tony on 6/27/16.
//  Copyright © 2016 sjtu. All rights reserved.
//

#import "GLVMainDealVC.h"
#import "Macro.h"
#import "IGLDropDownMenu.h"

@interface GLVMainDealVC ()<IGLDropDownMenuDelegate>

@property (nonatomic, strong) IGLDropDownMenu *dropDownMenu;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation GLVMainDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = TRUE;
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 2*Padding20, ScreenWidth - 2*Padding20)];
    self.imageView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    [self.view addSubview:self.imageView];
    self.imageView.image = self.srcImg;
    
    [self menuInfoInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)menuInfoInit{
//    const int menuWidth = 100;
    NSArray *menuValue = @[@{@"title" : @"灰度化", @"image" : @"icon_cat_08"},
                           @{@"title" : @"二值化", @"image" : @"icon_cat_10"},
                           @{@"title" : @"形态学", @"image" : @"icon_cat_16"},
                           @{@"title" : @"滤波", @"image" : @"icon_cat_03"},
                           @{@"title" : @"骨架", @"image" : @"icon_cat_17"}];
    
    NSMutableArray *menuArr = [NSMutableArray new];
    for (int i = 0; i < menuValue.count; i++) {
        NSDictionary *menuDic = menuValue[i];
        IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
        [item setIconImage:[UIImage imageNamed:menuDic[@"image"]]];
        [item setText:menuDic[@"title"]];
        [menuArr addObject:item];
    }

    
    self.dropDownMenu = [[IGLDropDownMenu alloc] init];
    self.dropDownMenu.menuText = @"Image effect";
    self.dropDownMenu.dropDownItems = menuArr;
    self.dropDownMenu.paddingLeft = 15;
    [self.dropDownMenu setFrame:CGRectMake(padding30, ScreenHeight - padding30 - 30, 150, 30)];
    self.dropDownMenu.delegate = self;
    self.dropDownMenu.direction = IGLDropDownMenuDirectionUp;
    self.dropDownMenu.alphaOnFold = 10;
    self.dropDownMenu.gutterY = 15;
    self.dropDownMenu.rotate = IGLDropDownMenuRotateRight;
    [self.view addSubview:self.dropDownMenu];
    [self.dropDownMenu reloadView];
}

- (void)dropDownMenu:(IGLDropDownMenu*)dropDownMenu selectedItemAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            [self showGrayMenu];
        }
            break;
        case 1:
        {
            [self showBinaryMenu];
        }
            break;
        case 2:
        {
            [self showSmoothingMenu];
        }
            break;
        case 3:
        {
            [self showEdgeMenu];
        }
            break;
        case 4:
        {
            [self showSkeletonMenu];
        }
            break;
        default:
            break;
    }
}

#pragma mark -- 菜单选择
- (void)showGrayMenu{
    
}

- (void)showBinaryMenu{
    
}

/**
 *  形态学菜单
 */
- (void)showMorphologyMenu{

}

/**
 *  边缘检测菜单
 */
- (void)showEdgeMenu{
    
}

/**
 *  滤波菜单
 */
- (void)showSmoothingMenu{

}

/**
 *  骨架菜单
 */
- (void)showSkeletonMenu{

}

#pragma mark -- 图像处理

/**
 *  灰度处理图像
 */
- (void)grayImageFilter{
    
}

/**
 *  二值图像处理
 */
- (void)binaryImageFilter{
    
}



#pragma mark --
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)saveBtnClick:(id)sender {
    
}


@end
