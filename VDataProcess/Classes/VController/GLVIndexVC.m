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

@interface GLVIndexVC ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,EAIntroDelegate>

@property (nonatomic, strong) UIButton *cameraBtn;
@property (nonatomic, strong) UIButton *albumBtn;

@property (strong, nonatomic) UIImagePickerController *imagePickerController;

@end

@implementation GLVIndexVC

- (void)viewDidLoad {
    [super viewDidLoad] ;
    // Do any additional setup after loading the view.
    self.cameraBtn.center = CGPointMake(self.view.center.x - ScreenWidth/8, self.view.center.y);
    self.albumBtn.center =CGPointMake(self.view.center.x + ScreenWidth/8, self.view.center.y);

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cameraBtn];
    [self.view addSubview:self.albumBtn];
    
    
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
        _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cameraBtn.frame = CGRectMake(0, 0, ScreenWidth/4, ScreenWidth/4);
        [_cameraBtn setImage:[UIImage imageNamed:@"icon_camera3"] forState:UIControlStateNormal];
        [_cameraBtn addTarget:self action:@selector(cameraBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cameraBtn;
}

- (UIButton *)albumBtn{
    if (_albumBtn == nil) {
        _albumBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _albumBtn.frame = CGRectMake(0, 0, ScreenWidth/4, ScreenWidth/4);
        [_albumBtn setImage:[UIImage imageNamed:@"icon_Album3"] forState:UIControlStateNormal];
        [_albumBtn addTarget:self action:@selector(albumBthClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _albumBtn;
}

#pragma mark -- introduce
- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Hello world";
    page1.desc = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.";
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"This is page 2";
    page2.desc = @"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore.";
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title2"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"This is page 3";
    page3.desc = @"Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.";
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"This is page 4";
    page4.desc = @"Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit.";
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    
    [intro showInView:self.view animateDuration:0.3];
}

#pragma mark - EAIntroView delegate
- (void)introDidFinish:(EAIntroView *)introView {
    NSLog(@"introDidFinish callback");
}
@end
