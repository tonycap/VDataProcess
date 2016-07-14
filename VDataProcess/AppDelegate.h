//
//  AppDelegate.h
//  VDataProcess
//
//  Created by tony on 6/27/16.
//  Copyright © 2016 V. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageAddPreView.h"

@class ImageAddPreView;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ImageAddPreView   *preview;

- (void)showPreView;
- (void)hiddenPreView;
@end

