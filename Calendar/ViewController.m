//
//  ViewController.m
//  Calendar
//
//  Created by 张瑞想 on 2017/7/3.
//  Copyright © 2017年 张瑞想. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+Calendar.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *DatePicker;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, strong) NSMutableArray *timeArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initDatas];
    self.DatePicker.delegate = self;
    self.DatePicker.dataSource = self;
}

- (void)initDatas
{
    self.dateArray = [NSMutableArray array];
    [self.dateArray addObject:@"暂不选择"];
    
    // 当前月
    NSDate *date = [NSDate date];
    [self addToArrayWithDate:date];
    
    // 下一个月
    NSDate *dateFirstDay = [date firstDayOfCurrentMonth];
    NSDate *nextMonthFirstDate = [dateFirstDay getMonthByAddingMonth:1];
    [self addToArrayWithDate:nextMonthFirstDate];

    self.timeArray = [NSMutableArray array];
    [self.timeArray addObject:@"暂不选择"];
    [self.timeArray addObject:@"09:00 - 12:00"];
    [self.timeArray addObject:@"13:00 - 17:00"];
}


- (void)addToArrayWithDate:(NSDate *)date
{
    // 获取月份
    NSInteger month = [date getMonth];
    
    // 当前的月的总天数
    NSInteger count = [date countOfDaysInCurrentMonth];
    
    // 获取当前月的第一天
    NSDate *dateFirstDay = [date firstDayOfCurrentMonth];
    
    // 获取当前月的第一天是周几 注意，周日是“1”，周一是“2”...周六是“7”（7%7=0）
    NSInteger weekFirstDay = [dateFirstDay getWeek];
    
    NSArray *weekNameArray = @[@"六",@"日",@"一",@"二",@"三",@"四",@"五"];
    
    int dayBegin = (int)[date getDay];
    
    for (int i = dayBegin; i <= count; i ++) {
        int week = (i - 1 + weekFirstDay) % 7;
        NSString *date = [NSString stringWithFormat:@"%ld月%d日【周%@】",(long)month, i, weekNameArray[week]];
        [self.dateArray addObject:date];
    }

}

# pragma mark - UIPickerViewDataSource

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return _dateArray.count;
    } else {
        return _timeArray.count;
    }
}

# pragma mark - UIPickerViewDelegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2.0, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0) {
        label.text = _dateArray[row];
    } else {
        label.text = _timeArray[row];
    }
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"component = %ld, row = %ld",component, row);
}

@end
