//
//  NSDate+Calendar.h
//  Calendar
//
//  Created by 张瑞想 on 2017/7/3.
//  Copyright © 2017年 张瑞想. All rights reserved.
//


/*
 
 在创建NSDate 需要获得准确时间的时候 使用下面的方法，日期可以准确一点
 
 当前日期2016-10－1；
 虽然打印date的是 2016-9-30 16:00:00 但是分别通过获得 年 月 日 却是2016 10 01
 
 通过下面获得的是 2016 10 01 00:00:00
 
 NSTimeZone *zone = [NSTimeZone systemTimeZone];
 NSInteger interval = [zone secondsFromGMTForDate: self];
 NSDate *localeDate = [self  dateByAddingTimeInterval: interval];
 NSLog(@"enddate=%@",localeDate);
 
 */

#import <Foundation/Foundation.h>

@interface NSDate (Calendar)

- (NSInteger)getMonth;

- (NSInteger)countOfDaysInCurrentMonth;

// 计算这个月的第一天
- (NSDate *)firstDayOfCurrentMonth;

// 计算是周几
- (NSInteger)getWeek;

- (NSInteger)getDay;

- (NSDate *)getMonthByAddingMonth:(NSInteger)month;

@end
