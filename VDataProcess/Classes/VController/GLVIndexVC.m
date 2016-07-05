//
//  GLVIndexVC.m
//  DImageFilter
//
//  Created by tony on 6/27/16.
//  Copyright © 2016 sjtu. All rights reserved.
//

#import "GLVIndexVC.h"

#import "Macro.h"
#import "EAIntroView.h"
#import "GLVMainDealVC.h"

#define FlagShowIntrodce    @"FlagShowIntrodce"
//引导界面 + About界面（还没实现）
//Page1:WelocomePage
static NSString * const sampleDescription1 = @"Welcome to my Original Face! This app is used to illustrate some fairly simaple operations of the digital image processing.";
//Page2:What is Face
static NSString * const sampleDescription2 = @"A design app of digital image processing system is presented, and realization of this system based on graphic user interface development and fundamental algorithms.";
//Page3:What can Face do ?
static NSString * const sampleDescription3 = @"And then it help puts forward the concept of image processing, studies and analyzes ordinary methods, which include image binarization，smoothing, edge detection, restoration and so on...";
//Page4:Enjoy the Face
static NSString * const sampleDescription4 = @"Choose some pictures you like to try this application. Hopy you enjoy it!";


@interface GLVIndexVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,EAIntroDelegate>

@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) UIButton *albumBtn;
@property (nonatomic, strong) UIButton *pintuBtn;
@property (nonatomic, strong) UIButton *aboutBtn;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation GLVIndexVC

- (void)viewDidLoad {
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    self.cameraBtn.center = CGPointMake(self.view.center.x - ScreenWidth/8, self.view.center.y - ScreenWidth/8);
    self.albumBtn.center = CGPointMake(self.view.center.x + ScreenWidth/8, self.view.center.y - ScreenWidth/8);
    self.pintuBtn.center = CGPointMake(self.view.center.x - ScreenWidth/8, self.view.center.y + ScreenWidth/8);
    self.aboutBtn.center = CGPointMake(self.view.center.x + ScreenWidth/8, self.view.center.y + ScreenWidth/8);

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.albumBtn];
    [self.view addSubview:self.aboutBtn];
    [self.view addSubview:self.pintuBtn];
    
    
    BOOL flag = [[NSUserDefaults standardUserDefaults] boolForKey:FlagShowIntrodce];
    if (!flag) {
        [self showIntroWithCrossDissolve];
        [[NSUserDefaults standardUserDefaults] setBool:TRUE forKey:FlagShowIntrodce];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = true;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = FALSE;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---
- (IBAction)cameraBtnClick:(id)sender{
    if (!self.imagePickerController) {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.allowsEditing = TRUE;
        self.imagePickerController.delegate = self;
    }
    
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;  //图片选择，只选择一个
    [self presentViewController:self.imagePickerController animated:true completion:nil];
}

- (IBAction)albumBthClick:(id)sender{
    if (!self.imagePickerController) {
        self.imagePickerController = [[UIImagePickerController alloc] init];
        self.imagePickerController.allowsEditing = TRUE;
        self.imagePickerController.delegate = self;
    }
    
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;  //图片选择，只选择一个
    [self presentViewController:self.imagePickerController animated:true completion:nil];
}

- (IBAction)pintuBtnClick:(id)sender{
    
}

- (IBAction)aboutBtnClick:(id)sender{
    [self showIntroWithCrossDissolve];
}

#pragma mark -- UIImagePickerControllerDelegate
// 用户选中图片之后的回调
- (void)imagePickerController: (UIImagePickerController *)picker didFinishPickingMediaWithInfo: (NSDictionary *)info{
    // 获得编辑过的图片
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    [self dismissViewControllerAnimated:true completion:^{
         [self showImgFilterWithImg:image];
    }];
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *)picker{
    // 关闭相册界面
    NSLog(@"cancel image picker Control");
    [self dismissViewControllerAnimated:true completion:^{
        
    }];
}

- (void)showImgFilterWithImg:(UIImage *)image{
    GLVMainDealVC *VC = [[GLVMainDealVC alloc] init];
    VC.srcImg = image;
    [self.navigationController pushViewController:VC animated:TRUE];
}

#pragma mark ---
- (UIButton *)cameraBtn{
    if (_cameraBtn == nil) {
        _cameraBtn = [self buttonInit];
        [_cameraBtn setImage:[UIImage imageNamed:@"icon_camera3"] forState:UIControlStateNormal];
        [_cameraBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cameraBtn;
}

- (UIButton *)albumBtn{
    if (_albumBtn == nil) {
        _albumBtn = [self buttonInit];
        [_albumBtn setImage:[UIImage imageNamed:@"icon_Album3"] forState:UIControlStateNormal];
        [_albumBtn addTarget:self action:@selector(albumBthClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _albumBtn;
}

- (UIButton *)pintuBtn{
    if (_pintuBtn == nil) {
        _pintuBtn = [self buttonInit];
        [_pintuBtn setImage:[UIImage imageNamed:@"icon_save"] forState:UIControlStateNormal];
        [_pintuBtn setTitle:@"拼图" forState:UIControlStateNormal];
        [_pintuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_pintuBtn addTarget:self action:@selector(pintuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _pintuBtn;
}

- (UIButton *)aboutBtn{
    if (_aboutBtn == nil) {
        _aboutBtn = [self buttonInit];
//        [_aboutBtn setImage:[UIImage imageNamed:@"icon_Album3"] forState:UIControlStateNormal];
        [_aboutBtn setTitle:@"关于" forState:UIControlStateNormal];
        [_aboutBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_aboutBtn addTarget:self action:@selector(aboutBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _aboutBtn;
}

- (UIButton *)buttonInit{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.contentMode = UIViewContentModeScaleToFill;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = .5f;
    btn.frame = CGRectMake(0, 0, ScreenWidth/4, ScreenWidth/4);
    
    return btn;
}

#pragma mark -- introduce
- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Welocome to Face !";
    page1.titleFont = [UIFont fontWithName:@"AmericanTypewriter" size:21];
    page1.titleColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    page1.titlePositionY = 220;
    page1.desc = sampleDescription1;
    page1.descFont = [UIFont fontWithName:@"ArialMT" size:14];
    page1.descColor = [UIColor whiteColor];
    page1.descPositionY = 190;
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    page1.titleIconPositionY = 105;

    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"What is Face ?";
    page2.titleFont = [UIFont fontWithName:@"AmericanTypewriter" size:21];
    page2.titleColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    page2.titlePositionY = 220 ;
    page2.desc = sampleDescription2;
    page2.descColor = [UIColor whiteColor];
    page2.descPositionY = 190;
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
    page2.titleIconPositionY = 105;
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"What can Face do ?";
    page3.titleFont = [UIFont fontWithName:@"AmericanTypewriter" size:21];
    page3.titleColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    page3.titlePositionY = 220 ;
    page3.desc = sampleDescription3;
    page3.descFont = [UIFont fontWithName:@"ArialMT" size:14];
    page3.descColor = [UIColor whiteColor];
    page3.descPositionY = 190;
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    page3.titleIconPositionY = 105;

    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"Enjoy the Face !";
    page4.titleFont = [UIFont fontWithName:@"AmericanTypewriter" size:21];
    page4.titleColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:255/255.0 alpha:1.0];
    page4.desc = sampleDescription4;
    page4.descFont = [UIFont fontWithName:@"ArialMT" size:14];
    page4.descColor = [UIColor whiteColor];
    page4.descPositionY = 190;
    page4.bgImage = [UIImage imageNamed:@"bg1"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    page4.titleIconPositionY = 105;
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    
    [intro showInView:self.view animateDuration:0.3];
}

#pragma mark - EAIntroView delegate
- (void)introDidFinish:(EAIntroView *)introView {
    NSLog(@"introDidFinish callback");
}
@end
