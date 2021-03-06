//
//  ViewController.m
//  ClockAnimation
//
//  Created by Pawan Sharma on 21/07/16.
//  Copyright © 2016 Hiteshi Infotech. All rights reserved.
//

#import "ViewController.h"

@interface ClockFace: CAShapeLayer

@property (nonatomic, strong) NSDate *time;

@end

@interface ClockFace ()

//private properties
@property (nonatomic, strong) CAShapeLayer *hourHand;
@property (nonatomic, strong) CAShapeLayer *minuteHand;
@property (nonatomic, strong) CAShapeLayer *secondHand;

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation ClockFace

- (id)init
{
    if ((self = [super init]))
	if (self == nil) { return nil; }
	
        self.bounds = CGRectMake(0, 0, 200, 200);
        self.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.fillColor = [UIColor whiteColor].CGColor;
        self.strokeColor = [UIColor blackColor].CGColor;
        self.lineWidth = 4;
        
		self.hourHand = [self createHourHand];
        [self addSublayer:self.hourHand];
        
        self.minuteHand = [self createMinuteHand];
        [self addSublayer:self.minuteHand];
        
        self.secondHand = [self createSecondHand];
        [self addSublayer:self.secondHand];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(_updateTime) userInfo:nil repeats:YES];
	
    return self;
}

- (CAShapeLayer *)createHourHand {
	CAShapeLayer *layer = [CAShapeLayer layer];
	layer.path = [UIBezierPath bezierPathWithRect:CGRectMake(-2, -70, 4, 70)].CGPath;
	layer.fillColor = [UIColor blackColor].CGColor;
	layer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
	return layer;
}

- (CAShapeLayer *)createMinuteHand {
	CAShapeLayer *layer = [CAShapeLayer layer];
	layer.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -90, 2, 90)].CGPath;
	layer.fillColor = [UIColor blackColor].CGColor;
	layer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
	return layer;
}

- (CAShapeLayer *)createSecondHand {
	CAShapeLayer *layer = [CAShapeLayer layer];
	layer.path = [UIBezierPath bezierPathWithRect:CGRectMake(-1, -90, .8, 90)].CGPath;
	layer.fillColor = [UIColor blackColor].CGColor;
	layer.position = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
	return layer;
}

- (void)_updateTime {
    [self setTime:[NSDate date]];
}

- (void)setTime:(NSDate *)time
{
    _time = time;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:time];
    self.hourHand.affineTransform = CGAffineTransformMakeRotation(components.hour / 12.0 * 2.0 * M_PI);
    self.minuteHand.affineTransform = CGAffineTransformMakeRotation(components.minute / 60.0 * 2.0 * M_PI);
    self.secondHand.affineTransform = CGAffineTransformMakeRotation(components.second / 60.0 * 2.0 * M_PI);
}

@end


@interface ViewController ()
@property (nonatomic, strong) ClockFace *clockFace;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //add clock face layer
    self.clockFace = [[ClockFace alloc] init];
    self.clockFace.position = CGPointMake(self.view.bounds.size.width / 2, 150);
    [self.view.layer addSublayer:self.clockFace];
    
    //set default time
    self.clockFace.time = [NSDate date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
