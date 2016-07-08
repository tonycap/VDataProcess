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

#import "UIImage+OpenCV.h"

@interface GLVMainDealVC ()<IGLDropDownMenuDelegate, GLMenuViewDelegate>

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
    [self.dropDownMenu setFrame:CGRectMake(padding30, padding30 + 40, 150, 30)];
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
    NSArray *grayMenu = @[@{@"title" : @"灰度图", @"image" : @"icon_cat_07", @"operateType":@(GrayTypeDeal)},
                          @{@"title" : @"直方图", @"image" : @"icon_cat_08", @"operateType":@(GrayTypeHist)},
                          @{@"title" : @"均衡化", @"image" : @"icon_cat_09", @"operateType":@(GrayTypeEqual)},
                          @{@"title" : @"直方图均衡化", @"image" : @"icon_cat_10", @"operateType":@(GrayTypeHistEqual)}
                          ];
    [self showMenuViewWithArr:grayMenu];
}

- (void)showBinaryMenu{
    NSArray *binMenu = @[@{@"title" : @"迭代法", @"image" : @"icon_cat_01", @"operateType":@(BinaryTypeDetech)},
                         @{@"title" : @"OTSU法", @"image" : @"icon_cat_02", @"operateType":@(BinaryTypeOTSU)},
                         @{@"title" : @"熵阈值", @"image" : @"icon_cat_03", @"operateType":@(BinaryTypeMaxEntropy)},
                         @{@"title" : @"全局阈值", @"image" : @"icon_cat_04", @"operateType":@(BinaryTypeGlobal)},
                         @{@"title" : @"自定义阈值", @"image" : @"icon_cat_05", @"operateType":@(BinaryTypeCustom)}
                         ];
    [self showMenuViewWithArr:binMenu];
}

/**
 *  形态学菜单
 */
- (void)showMorphologyMenu{
    NSArray *morphology = @[@{@"title" : @"腐蚀", @"image" : @"icon_cat_11", @"operateType":@(MorphologytypeErosion)},
                            @{@"title" : @"膨胀", @"image" : @"icon_cat_12", @"operateType":@(MorphologytypeDilate)},
                            @{@"title" : @"开运算", @"image" : @"icon_cat_13", @"operateType":@(MorphologytypeOpen)},
                            @{@"title" : @"闭运算", @"image" : @"icon_cat_14", @"operateType":@(MorphologytypeClose)},
                            @{@"title" : @"形态学梯度", @"image" : @"icon_cat_15", @"operateType":@(MorphologytypeGradient)},
                            @{@"title" : @"顶帽", @"image" : @"icon_cat_16", @"operateType":@(MorphologytypeTopHat)},
                            @{@"title" : @"黑帽", @"image" : @"icon_cat_17", @"operateType":@(MorphologytypeBlackHat)}
                            ];
    [self showMenuViewWithArr:morphology];
}

/**
 *  边缘检测菜单
 */
- (void)showEdgeMenu{
    NSArray *edgeMenu = @[@{@"title" : @"sobel算子", @"image" : @"icon_cat_18", @"operateType":@(EdgeTypeSobel)},
                          @{@"title" : @"canny算子", @"image" : @"icon_cat_19", @"operateType":@(EdgeTypeCanny)},
                          @{@"title" : @"Laplace算子", @"image" : @"icon_cat_01", @"operateType":@(EdgeTypeLaplace)},
                          @{@"title" : @"scharr算子", @"image" : @"icon_cat_02", @"operateType":@(EdgeTypeScharr)},
                          @{@"title" : @"Roberts算子", @"image" : @"icon_cat_03", @"operateType":@(EdgeTypeRoberts)},
                          @{@"title" : @"Prewitt算子", @"image" : @"icon_cat_04", @"operateType":@(EdgeTypePrewitt)}
                          ];
    
    [self showMenuViewWithArr:edgeMenu];
}

/**
 *  滤波菜单
 */
- (void)showSmoothingMenu{
    NSArray *smoothingMenu = @[@{@"title" : @"方框滤波", @"image" : @"icon_cat_05", @"operateType":@(SmoothTypeBoxBlur)},
                               @{@"title" : @"均值滤波", @"image" : @"icon_cat_06", @"operateType":@(SmoothTypeBlur)},
                               @{@"title" : @"高斯滤波", @"image" : @"icon_cat_07", @"operateType":@(SmoothTypeGussianBlur)},
                               @{@"title" : @"中值滤波", @"image" : @"icon_cat_08", @"operateType":@(SmoothTypeMedianBlur)},
                               @{@"title" : @"双边滤波", @"image" : @"icon_cat_09", @"operateType":@(SmoothTypeBilatelBlur)}
                               ];
    [self showMenuViewWithArr:smoothingMenu];
}

/**
 *  骨架菜单
 */
- (void)showSkeletonMenu{
    NSArray *sketetonMenu = @[@{@"title" : @"距离转换", @"image" : @"icon_cat_10", @"operateType":@(SkeletonTypeDistanceTransform)},
                              @{@"title" : @"hilditch细化", @"image" : @"icon_cat_11", @"operateType":@(SkeletonTypeHilditch)},
                              @{@"title" : @"Rosenfeld细化", @"image" : @"icon_cat_12", @"operateType":@(SkeletonTypeRosenfeld)},
                              @{@"title" : @"形态学骨架", @"image" : @"icon_cat_13", @"operateType":@(SkeletonTypeMorph)}
                              ];
    [self showMenuViewWithArr:sketetonMenu];
}

- (void)showMenuViewWithArr:(NSArray *)menuArr{
    if (self.menuView) {
        [self.menuView removeFromSuperview];
    }
    self.menuView = [[GLMenuView alloc] initWithFrame:CGRectMake(0, ScreenHeight - 100, ScreenWidth, 100) withMenuItem:menuArr];
    self.menuView.delegate = self;
    [self.view addSubview:self.menuView];
}

#pragma mark -- 图像处理

#pragma mark - GLMenuViewDelegate
- (void)itemInfoChange:(id)itemInfo sliderValue:(NSInteger)value{
    NSString *typeStr = [[itemInfo objectForKey:@"operateType"] stringValue];
    NSLog(@"itemInfo %@, value: %@", itemInfo, @(value));
    
    if ([typeStr hasPrefix:@"100"]) {
        [self grayWithType:[typeStr integerValue]];
    }else if ([typeStr hasPrefix:@"200"]){
        [self binaryWithType:[typeStr integerValue] sliderValue:value];
    }else if ([typeStr hasPrefix:@"300"]){
        [self morphologyWithType:[typeStr integerValue] sliderValue:value];
    }else if ([typeStr hasPrefix:@"400"]){
        [self edgeWithType:[typeStr integerValue] sliderValue:value];
    }else if ([typeStr hasPrefix:@"500"]){
        [self smoothingType:[typeStr integerValue] sliderValue:value];
    }else if ([typeStr hasPrefix:@"600"]){
        [self skeletonType:[typeStr integerValue] sliderValue:value];
    }
}

/**
 *  灰度处理图像
 */
- (void)grayWithType:(NSInteger)type{
    switch (type) {
        case GrayTypeDeal:
        {
            self.imageView.image = [self.srcImg grayImage];
        }
            break;
        case GrayTypeHist:
        {
            self.imageView.image = [self.srcImg grayHistImg];
        }
            break;
        case GrayTypeEqual:
        {
            self.imageView.image = [self.srcImg equalHistImg];
        }
            break;
        case GrayTypeHistEqual:
        {
            self.imageView.image = [self.srcImg histogramEqualization];
        }
            break;
        default:
            break;
    }
}

/**
 *  二值图像处理
 */
- (void)binaryWithType:(NSInteger)type sliderValue:(NSInteger)value{
    switch (type) {
        case BinaryTypeMaxEntropy:
        {
            self.imageView.image = [self.srcImg binaryzationWithMaxEntropy];
        }
            break;
        case BinaryTypeGlobal:
        {
            self.imageView.image = [self.srcImg binaryzationWithWithGlobalThrehold];
        }
            break;
            
        case BinaryTypeDetech:
        {
            self.imageView.image = [self.srcImg binaryzationWithWithDetech];
        }
            break;
        case BinaryTypeOTSU:
        {
            self.imageView.image = [self.srcImg binaryzation];
        }
            break;
        case BinaryTypeCustom:
        {
            self.imageView.image = [self.srcImg binaryzationWithThresh:(int)value];
        }
            break;
        default:
            break;
    }
}

- (void)morphologyWithType:(NSInteger)type sliderValue:(NSInteger)value{
    int size = (value == 0 ? 2 : (int)value);
    
    switch (type) {
        case MorphologytypeErosion:
        {
            self.imageView.image = [self.srcImg erosionType:1 size:size];
        }
            break;
        case MorphologytypeDilate:
        {
            self.imageView.image = [self.srcImg dilationWithType:1 size:size];
        }
            break;
        case MorphologytypeOpen:
        {
            self.imageView.image = [self.srcImg morphologyWithOperation:0 elementSize:size];
        }
            break;
        case MorphologytypeClose:
        {
            self.imageView.image = [self.srcImg morphologyWithOperation:1 elementSize:size];
        }
            break;
        case MorphologytypeGradient:
        {
            self.imageView.image = [self.srcImg morphologyWithOperation:2 elementSize:size];
        }
            break;
        case MorphologytypeTopHat:
        {
            self.imageView.image = [self.srcImg morphologyWithOperation:3 elementSize:size];
        }
            break;
        case MorphologytypeBlackHat:
        {
            self.imageView.image = [self.srcImg morphologyWithOperation:4 elementSize:size];
        }
            break;
            
        default:
            break;
    }
}

- (void)edgeWithType:(NSInteger)type sliderValue:(NSInteger)value{
    int size = (value == 0 ? 3 : (int)value);
    switch (type) {
        case EdgeTypeSobel:
        {
            self.imageView.image = [self.srcImg sobelWithScale:size];
        }
            break;
        case EdgeTypeCanny:
        {
            self.imageView.image = [self.srcImg cannyWithThreshold:size];
        }
            break;
        case EdgeTypeLaplace:
        {
            self.imageView.image = [self.srcImg LaplaceWithSize:size];
        }
            break;
        case EdgeTypeScharr:
        {
            self.imageView.image = [self.srcImg scharrWithScale:size];
        }
            break;
        case EdgeTypeRoberts:
        {
            self.imageView.image = [self.srcImg robertsEdge];
        }
            break;
        case EdgeTypePrewitt:
        {
            self.imageView.image = [self.srcImg prewittEdge];
        }
            break;
        default:
            break;
    }
}

- (void)smoothingType:(NSInteger)type sliderValue:(NSInteger)value{
    int size = [self value:(int)value defaultValue:3];
    switch (type) {
        case SmoothTypeBoxBlur:
        {
            self.imageView.image = [self.srcImg boxBlurFilterWithSize:size];
        }
            break;
        case SmoothTypeBlur:
        {
            self.imageView.image = [self.srcImg blureFilterWithSize:size];
        }
            break;
        case SmoothTypeGussianBlur:
        {
            self.imageView.image = [self.srcImg gaussianBlurFilterWithSize:size];
        }
            break;
        case SmoothTypeMedianBlur:
        {
            self.imageView.image = [self.srcImg medianFilterWithkSize:size];
        }
            break;
        case SmoothTypeBilatelBlur:
        {
            self.imageView.image = [self.srcImg bilateralFilterWithSie:size];
        }
            break;
        default:
            break;
    }
}

- (void)skeletonType:(NSInteger)type sliderValue:(NSInteger)value{
    switch (type) {
        case SkeletonTypeDistanceTransform:
        {
            self.imageView.image = [self.srcImg distanceTransform];
        }
            break;
        case SkeletonTypeHilditch:
        {
            self.imageView.image = [self.srcImg skeletonByHilditch];
        }
            break;
        case SkeletonTypeRosenfeld:
        {
            self.imageView.image = [self.srcImg skeletonByRosenfeld];
        }
            break;
        case SkeletonTypeMorph:
        {
            self.imageView.image = [self.srcImg skeletonByMorph];
        }
            break;
        default:
            break;
    }
}

- (int)value:(int)value defaultValue:(int)defaultValue{
    int retValue = (value == 0 ? defaultValue : value);
    
    return retValue;
}

#pragma mark --
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)saveBtnClick:(id)sender {
    
}

@end