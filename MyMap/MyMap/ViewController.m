//
//  ViewController.m
//  MyMap
//
//  Created by hhuuqq on 15/10/12.
//  Copyright (c) 2015年 lanou3g. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MyAnnotation.h"
@interface ViewController ()<MKMapViewDelegate>

@property (nonatomic,strong) MKMapView *mapView;

@property (nonatomic,strong) CLLocationManager *manger;

@property (nonatomic,strong) UIImage *icon;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MKMapView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.mapView];
    
    self.mapView.mapType = MKMapTypeStandard;
    
    // 设置地图中心
//    CLLocationCoordinate2D locate = CLLocationCoordinate2DMake(40, 90);
//    [self.mapView setCenterCoordinate:locate];
//    
//    // 设置地图显示范围
//    [self.mapView setRegion:MKCoordinateRegionMake(locate, MKCoordinateSpanMake(1, 1))];
    
    // 跟踪用户 打开用户的位置
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
    
    self.manger = [[CLLocationManager alloc]init];
    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        // 向设备申请"程序使用中时,使用定位功能"
        [self.manger requestWhenInUseAuthorization];
    }
    self.mapView.delegate = self;
    
    // 是否允许地图旋转
    self.mapView.rotateEnabled = NO;
}


// 定位成功的方法
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    NSLog(@"定位成功");
}

- (void) mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"定位失败");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 屏幕开始发生变化
- (void) mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
    NSLog(@"屏幕区域将要发生变化");
}


// 屏幕区域变化结束
- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    NSLog(@"屏幕变化结束");
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    MyAnnotation *ann = [[MyAnnotation alloc]init];
    ann.coordinate = CLLocationCoordinate2DMake(40, 116);
    ann.title = @"哥在此";
    ann.subtitle = @"开";
    ann.icon = [UIImage imageNamed:@"22.png"];
    [self.mapView addAnnotation:ann];
}

// 改变大头针的图片
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    static NSString *identifier = @"identifire";
    MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!pinAnnotationView) {
        pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: identifier];
        
    }
   
    // 设置大头针的属性
    pinAnnotationView.annotation = annotation;
    // 刚开始没有大头针,因此要做一个判断进行返回
    if (![annotation isKindOfClass:[MyAnnotation class]]) return nil;
    pinAnnotationView.image = ((MyAnnotation *)annotation).icon;
   
    // 设置可以显示冒泡上的左右图片
//    pinAnnotationView.leftCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"22.png"]];
//    pinAnnotationView.rightCalloutAccessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"22.png"]];
    
    // 从天而降(动画，只有用系统大头针样式才起作用)
    // pinAnnotationView.animatesDrop = YES;
    
    //气泡偏移量
    pinAnnotationView.calloutOffset = CGPointMake(0, 0);
    // 设置可以显示冒泡
    pinAnnotationView.canShowCallout = YES;
    
    return pinAnnotationView;
}

@end
