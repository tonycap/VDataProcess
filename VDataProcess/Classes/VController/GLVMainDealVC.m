//
//  GLVMainDealVC.m
//  DImageFilter
//
//  Created by tony on 6/27/16.
//  Copyright © 2016 sjtu. All rights reserved.
//

#import "GLVMainDealVC.h"
#import "Macro.h"
#import "MenuHrizontal.h"

@interface GLVMainDealVC ()<MenuHrizontalDelegate>

@property (nonatomic, strong) MenuHrizontal *menuView;

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
    const int menuWidth = 100;
    NSArray *menuValue = @[@{@"title" : @"灰度化", @"image" : @""},
                           @{@"title" : @"二值化", @"image" : @""},
                           @{@"title" : @"形态学", @"image" : @""},
                           @{@"title" : @"滤波", @"image" : @""},
                           @{@"title" : @"骨架", @"image" : @""}];
    
    NSMutableArray *menuArr = [NSMutableArray new];
    for (int i = 0; i < menuValue.count; i++) {
        NSDictionary *menuDic = menuValue[i];
        
        NSDictionary *item = @{NOMALKEY : @"normal",
                               HEIGHTKEY : @"helight",
                               TITLEKEY : [menuDic objectForKey:@"title"],
                               TITLEWIDTH : @(menuWidth)};
        [menuArr addObject:item];
    }
    
    self.menuView = [[MenuHrizontal alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(self.bottomView.bounds)) ButtonItems:menuArr];
    self.menuView.delegate = self;
    [self.bottomView addSubview:self.menuView];
    self.bottomView.backgroundColor = [UIColor orangeColor];
    [self.menuView clickButtonAtIndex:0];
}

#pragma mark -- 
- (void)didMenuHrizontalClickedButtonAtIndex:(NSInteger)aIndex{
    switch (aIndex) {
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
