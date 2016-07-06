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
#import "GLMenuView.h"

@interface GLVMainDealVC ()<IGLDropDownMenuDelegate>

@property (nonatomic, strong) IGLDropDownMenu *dropDownMenu;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) GLMenuView *menuView;

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
    
    self.bottomView.hidden = TRUE;
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
    [self.dropDownMenu setFrame:CGRectMake(padding30, padding30 + 80, 150, 30)];
    self.dropDownMenu.delegate = self;
    self.dropDownMenu.direction = IGLDropDownMenuDirectionDown;
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
    NSArray *grayMenu = @[@{@"title" : @"灰度图", @"image" : @"icon_cat_07", @"operateType":@(2)},
                          @{@"title" : @"直方图", @"image" : @"icon_cat_08", @"operateType":@(2)},
                          @{@"title" : @"均衡化", @"image" : @"icon_cat_09", @"operateType":@(2)},
                          @{@"title" : @"直方图均衡化", @"image" : @"icon_cat_10", @"operateType":@(2)}
                          ];
    
    if (self.menuView) {
        [self.menuView removeFromSuperview];
    }
    self.menuView = [[GLMenuView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100) withMenuItem:grayMenu];
    [self.view addSubview:self.menuView];
    
}

- (void)showBinaryMenu{
    NSArray *binMenu = @[@{@"title" : @"迭代法", @"image" : @"icon_cat_01", @"operateType":@(2)},
                        @{@"title" : @"OTSU法", @"image" : @"icon_cat_02", @"operateType":@(2)},
                        @{@"title" : @"熵阈值", @"image" : @"icon_cat_03", @"operateType":@(2)},
                        @{@"title" : @"全局阈值", @"image" : @"icon_cat_04", @"operateType":@(2)},
                        @{@"title" : @"自定义阈值", @"image" : @"icon_cat_05", @"operateType":@(2)}
                        ];
    
    if (self.menuView) {
        [self.menuView removeFromSuperview];
    }
    self.menuView = [[GLMenuView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100) withMenuItem:binMenu];
    [self.view addSubview:self.menuView];
}

/**
 *  形态学菜单
 */
- (void)showMorphologyMenu{
    NSArray *morphology = @[@{@"title" : @"腐蚀", @"image" : @"icon_cat_11", @"operateType":@(3)},
                            @{@"title" : @"膨胀", @"image" : @"icon_cat_12", @"operateType":@(3)},
                            @{@"title" : @"开运算", @"image" : @"icon_cat_13", @"operateType":@(3)},
                            @{@"title" : @"闭运算", @"image" : @"icon_cat_14", @"operateType":@(3)},
                            @{@"title" : @"形态学梯度", @"image" : @"icon_cat_15", @"operateType":@(3)},
                            @{@"title" : @"顶帽", @"image" : @"icon_cat_16", @"operateType":@(3)},
                            @{@"title" : @"黑帽", @"image" : @"icon_cat_17", @"operateType":@(3)}
                            ];
    
    if (self.menuView) {
        [self.menuView removeFromSuperview];
    }
    self.menuView = [[GLMenuView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100) withMenuItem:morphology];
    [self.view addSubview:self.menuView];
}

/**
 *  边缘检测菜单
 */
- (void)showEdgeMenu{
    NSArray *edgeMenu = @[@{@"title" : @"sobel算子", @"image" : @"icon_cat_18", @"operateType":@(6)},
                          @{@"title" : @"canny算子", @"image" : @"icon_cat_19", @"operateType":@(6)},
                          @{@"title" : @"Laplace算子", @"image" : @"icon_cat_01", @"operateType":@(6)},
                          @{@"title" : @"scharr算子", @"image" : @"icon_cat_02", @"operateType":@(6)},
                          @{@"title" : @"Roberts算子", @"image" : @"icon_cat_03", @"operateType":@(6)},
                          @{@"title" : @"Prewitt算子", @"image" : @"icon_cat_04", @"operateType":@(6)}
                          ];
    if (self.menuView) {
        [self.menuView removeFromSuperview];
    }
    self.menuView = [[GLMenuView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100) withMenuItem:edgeMenu];
    [self.view addSubview:self.menuView];
}

/**
 *  滤波菜单
 */
- (void)showSmoothingMenu{
    NSArray *smoothingMenu = @[@{@"title" : @"方框滤波", @"image" : @"icon_cat_05", @"operateType":@(4)},
                          @{@"title" : @"均值滤波", @"image" : @"icon_cat_06", @"operateType":@(4)},
                          @{@"title" : @"高斯滤波", @"image" : @"icon_cat_07", @"operateType":@(4)},
                          @{@"title" : @"中值滤波", @"image" : @"icon_cat_08", @"operateType":@(4)},
                          @{@"title" : @"双边滤波", @"image" : @"icon_cat_09", @"operateType":@(4)}
                          ];
    if (self.menuView) {
        [self.menuView removeFromSuperview];
    }
    self.menuView = [[GLMenuView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100) withMenuItem:smoothingMenu];
    [self.view addSubview:self.menuView];
}

/**
 *  骨架菜单
 */
- (void)showSkeletonMenu{
    NSArray *sketetonMenu = @[@{@"title" : @"距离转换", @"image" : @"icon_cat_10", @"operateType":@(5)},
                          @{@"title" : @"hilditch细化", @"image" : @"icon_cat_11", @"operateType":@(5)},
                          @{@"title" : @"Rosenfeld细化", @"image" : @"icon_cat_12", @"operateType":@(5)},
                          @{@"title" : @"形态学骨架", @"image" : @"icon_cat_13", @"operateType":@(5)}
                          ];
    
    if (self.menuView) {
        [self.menuView removeFromSuperview];
    }
    self.menuView = [[GLMenuView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100) withMenuItem:sketetonMenu];
    [self.view addSubview:self.menuView];
    
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
