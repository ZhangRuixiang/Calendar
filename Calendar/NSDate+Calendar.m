//
//  NSDate+Calendar.m
//  Calendar
//
//  Created by 张瑞想 on 2017/7/3.
//  Copyright © 2017年 张瑞想. All rights reserved.
//

#import "NSDate+Calendar.h"

@implementation NSDate (Calendar)

- (NSInteger)getMonth
{
    NSCalendar *calender = [NSCalendar currentCalendar];
    NSDateComponents *components = [calender components:NSCalendarUnitMonth fromDate:self];
    return components.month;
}

- (NSInteger)getWeek
{
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps =[calendar components:(NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal) fromDate:self];
    
    // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSInteger weekday = [comps weekday];    
    return weekday;
}

- (NSInteger)getDay
{
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps =[calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay)
                                        fromDate:self];
    NSInteger day = [comps day];
    return day;
}

- (NSInteger)countOfDaysInCurrentMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

- (NSDate *)getMonthByAddingMonth:(NSInteger)month
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *lastMonthComps = [[NSDateComponents alloc] init];
    
    // 设置增加的
    [lastMonthComps setMonth:month];
    NSDate *newDate = [calendar dateByAddingComponents:lastMonthComps toDate:self options:0];
    return newDate;
}
@end
