//
//  MyAnnotation.h
//  MyMap
//
//  Created by hhuuqq on 15/10/12.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
// 定义一个类遵循了MKAnnotation(大头针)
@interface MyAnnotation : NSObject<MKAnnotation>

// 大头针的位置
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,copy) NSString *subtitle;

// 大头针的图片(自己定义)
@property (nonatomic,copy) UIImage *icon;

@end
