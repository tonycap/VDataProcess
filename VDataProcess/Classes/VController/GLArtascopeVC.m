//
//  GLArtascopeVC.m
//  VDataProcess
//
//  Created by tony on 7/7/16.
//  Copyright © 2016 V. All rights reserved.
//

#import "GLArtascopeVC.h"

#import "ASValueTrackingSlider.h"
#import "Macro.h"


@interface ArtSlider : ASValueTrackingSlider

@property (nonatomic) NSString *attributeKey;

@end

@implementation ArtSlider

- (void)setupWithAttributes:(NSDictionary*)attributes forKey:(NSString*)attrKey
{
    NSDictionary *attr = attributes[attrKey];
    self.minimumValue = [attr[kCIAttributeSliderMin] floatValue];
    self.maximumValue = [attr[kCIAttributeSliderMax] floatValue];
    self.value = [attr[kCIAttributeDefault] floatValue];
    self.attributeKey = attrKey;
}

@end


@interface GLArtascopeVC (){
    CIFilter *filter;
    CGRect imageRect;
}

@property (nonatomic, strong) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet ArtSlider *sizeSlider;
@property (weak, nonatomic) IBOutlet ArtSlider *rotationSlider;
@property (weak, nonatomic) IBOutlet ArtSlider *decaySlider;

@end

@implementation GLArtascopeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBarHidden = FALSE;
    
    filter = [CIFilter filterWithName:@"CITriangleKaleidoscope"];
    
    [self.sizeSlider setupWithAttributes:filter.attributes forKey:@"inputSize"];
    [self.rotationSlider setupWithAttributes:filter.attributes forKey:@"inputRotation"];
    [self.decaySlider setupWithAttributes:filter.attributes forKey:@"inputDecay"];
//    self.sizeSlider.delegate = self;
//    self.rotationSlider.delegate = self;
//    self.decaySlider.delegate = self;
    
    UIImage *image;
    if (!self.originImg) {
        image = [UIImage imageNamed:@"taberu"];
    }
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 2*Padding20, ScreenWidth - 2*Padding20)];
    self.imageView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    self.imageView.image = image;
    self.imageView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:self.imageView];
    
    CGSize size = self.imageView.image.size;
    [filter setValue:[CIImage imageWithCGImage:image.CGImage] forKey:kCIInputImageKey];
    [filter setValue:[CIVector vectorWithX:size.width/2 Y:size.height/2] forKey:@"inputPoint"];
    
    imageRect = CGRectMake(0, 0, size.width, size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
     self.navigationController.navigationBarHidden = true;
}

- (IBAction)valueChanged:(id)sender {
    ArtSlider *slider = (ArtSlider *)sender;
    [filter setValue:@(slider.value) forKey:slider.attributeKey];
    NSLog(@"attributeKey %@ value: %@", slider.attributeKey, @(slider.value));
    
    CIImage *result = filter.outputImage;
    if (result) {
        CIContext *context = [CIContext contextWithOptions:nil];
        CGImageRef cgImage = [context createCGImage:result fromRect:imageRect];
        UIImage *filterImg = [UIImage imageWithCGImage:cgImage];
        self.imageView.image = filterImg;
        CGImageRelease(cgImage);
    } else {
        NSLog(@"warning: nil result");
    }

}

@end
