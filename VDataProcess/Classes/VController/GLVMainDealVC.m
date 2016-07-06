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
    NSArray *menuValue = @[@{@"title" : @"灰度化", @"image" : @"icon_cat_8"},
                           @{@"title" : @"二值化", @"image" : @"icon_cat_10"},
                           @{@"title" : @"形态学", @"image" : @"icon_cat_16"},
                           @{@"title" : @"滤波", @"image" : @"icon_cat_3"},
                           @{@"title" : @"骨架", @"image" : @"icon_cat_17"}];
    
    self.dropDownMenu = [[IGLDropDownMenu alloc] init];
    self.dropDownMenu.menuText = @"Image effect";
    self.dropDownMenu.dropDownItems = menuValue;
    self.dropDownMenu.paddingLeft = 15;
    [self.dropDownMenu setFrame:CGRectMake(padding30, ScreenHeight - padding30 - 30, 200, 30)];
    self.dropDownMenu.delegate = self;
    self.dropDownMenu.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.dropDownMenu];
//    [self.dropDownMenu reloadView];
}

- (void)dropDownMenu:(IGLDropDownMenu*)dropDownMenu selectedItemAtIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        default:
            break;
    }
}

#pragma mark --
- (IBAction)backBtnClick:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)saveBtnClick:(id)sender {
    
}


@end
