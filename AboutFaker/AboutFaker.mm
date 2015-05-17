//
//  AboutFaker.mm
//  AboutFaker
//
//  Created by NobitaZZZ on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

// CaptainHook by Ryan Petrich
// see https://github.com/rpetrich/CaptainHook/

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CaptainHook/CaptainHook.h"
//#include <notify.h> // not required; for examples only

// Objective-C runtime hooking using CaptainHook:
//   1. declare class using CHDeclareClass()
//   2. load class using CHLoadClass() or CHLoadLateClass() in CHConstructor
//   3. hook method using CHOptimizedMethod()
//   4. register hook using CHHook() in CHConstructor
//   5. (optionally) call old method using CHSuper()

/*
@interface AboutFaker : NSObject

@end

@implementation AboutFaker

-(id)init
{
	if ((self = [super init]))
	{
	}

    return self;
}

@end
 */


/*
@class UIView;
CHDeclareClass(UIView);
CHMethod(1, void, UIView, addSubview, UIView *, v) // hook method (with 2 arguments and a return value)
{
	// write code here ...
    //NSLog(@"addSubview %@ %@", self, v);
    
    
	CHSuper(1, UIView, addSubview, v); // call old (original) method and return its return value
}


CHConstructor // code block that runs immediately upon load
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	CHLoadClass(UIView); // load class (that is "available now")
	CHHook(1, UIView, addSubview); // register hook
	
	[pool drain];
}



//- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
@class NSObject;
CHDeclareClass(NSObject);
CHMethod(2, void, NSObject, pushViewController, UIViewController *, viewController, animated, BOOL, animated) // hook method (with 2 arguments and a return value)
{
	// write code here ...
    NSLog(@"pushViewController %@ %@", self, viewController);
	CHSuper(2, NSObject, pushViewController, viewController, animated, animated); // call old (original) method and return its return value
}


CHConstructor // code block that runs immediately upon load
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	CHLoadClass(NSObject); // load class (that is "available now")
	CHHook(2, NSObject, pushViewController, animated); // register hook
	
	[pool drain];
}
 */



//(UIPreferencesTableCell)preferencesTable:(UIPreferencesTable)aTable cellForRow:(int)row inGroup:(int)group;

@interface UIPreferencesTableCell
-(void)setValue:(id)value;
-(id)title;
@end

@class AboutController, UIPreferencesTableCell, UIPreferencesTable;
CHDeclareClass(AboutController);
CHOptimizedMethod(3,self, UIPreferencesTableCell *, AboutController, preferencesTable, UIPreferencesTable *, tableView, cellForRow, int, row, inGroup, int, group) // hook method (with 2 arguments and a return value)
{
	// write code here ...
	UIPreferencesTableCell *c = CHSuper(3, AboutController, preferencesTable, tableView, cellForRow, row, inGroup, group);
    
    //NSLog(@"cellForRow %@", [c title]);
    
    
    if([[c title] isEqualToString:@"Serial Number"]){
        [c setValue:@"87840SM4Y7H"];
    }else if([[c title] isEqualToString:@"IMEI"]){
        [c setValue:@"01 174400 847387 8"];
    }
    
    return c;
    
    
    /*
    [c setValue:@"xxx"];
    NSLog(@"cellForRow %@", [c valueTextLabel]);
    return c;
    NSLog(@"cellForRow %@ %@", [[c textLabel] text], [[c detailTextLabel] text]);
    if([[[c textLabel] text] isEqualToString:@"IMEI"]){
        //c.detailTextLabel.text = @"011744008473878";
    }else if([[[c textLabel] text] isEqualToString:@"Serial Number"]){
        //c.detailTextLabel.text = @"87840SM4Y7H";
    }
    return c;
     */
}


CHConstructor // code block that runs immediately upon load
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
	CHLoadLateClass(AboutController); // load class (that is "available now")
	CHHook(3, AboutController, preferencesTable, cellForRow, inGroup); // register hook
	
	[pool drain];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
/*

@class ClassToHook;

CHDeclareClass(ClassToHook); // declare class

CHOptimizedMethod(0, self, void, ClassToHook, messageName) // hook method (with no arguments and no return value)
{
	// write code here ...
	
	CHSuper(0, ClassToHook, messageName); // call old (original) method
}

CHOptimizedMethod(2, self, BOOL, ClassToHook, arg1, NSString*, value1, arg2, BOOL, value2) // hook method (with 2 arguments and a return value)
{
	// write code here ...

	return CHSuper(2, ClassToHook, arg1, value1, arg2, value2); // call old (original) method and return its return value
}

static void WillEnterForeground(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	// not required; for example only
}

static void ExternallyPostedNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	// not required; for example only
}

CHConstructor // code block that runs immediately upon load
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	// listen for local notification (not required; for example only)
	CFNotificationCenterRef center = CFNotificationCenterGetLocalCenter();
	CFNotificationCenterAddObserver(center, NULL, WillEnterForeground, CFSTR("UIApplicationWillEnterForegroundNotification"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	
	// listen for system-side notification (not required; for example only)
	// this would be posted using: notify_post("com.nobitazzz.AboutFaker.eventname");
	CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
	CFNotificationCenterAddObserver(darwin, NULL, ExternallyPostedNotification, CFSTR("com.nobitazzz.AboutFaker.eventname"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	
	// CHLoadClass(ClassToHook); // load class (that is "available now")
	// CHLoadLateClass(ClassToHook);  // load class (that will be "available later")
	
	CHHook(0, ClassToHook, messageName); // register hook
	CHHook(2, ClassToHook, arg1, arg2); // register hook
	
	[pool drain];
}
*/