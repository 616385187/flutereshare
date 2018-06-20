//
//  ESCommandCode.h
//  Eshare_O
//
//  Created by EShare on 16/8/16.
//  Copyright © 2016年 Eshare. All rights reserved.


// socket命令中的宏定义

#ifndef ESCommandCode_h
#define ESCommandCode_h


#define  TYPE_UNKNOWN -1
#define TYPE_ANDROID  0
#define TYPE_IPHONE  1
#define TYPE_WINDOWS  2
#define TYPE_MAC  3
#define TYPE_IPAD  4

#define action_default  -1
#define action_down 0
#define action_up   1
#define action_move 2
#define action_pointer_down 5
#define action_pointer_up   6



#define  KEYCODE_HOME             3
#define  KEYCODE_BACK             4
/** Key code constant: Directional Pad Up key.
 * May also be synthesized from trackball motions. */
#define  KEYCODE_DPAD_UP          19
/** Key code constant: Directional Pad Down key.
 * May also be synthesized from trackball motions. */
#define  KEYCODE_DPAD_DOWN        20
/** Key code constant: Directional Pad Left key.
 * May also be synthesized from trackball motions. */
#define  KEYCODE_DPAD_LEFT        21
/** Key code constant: Directional Pad Right key.
 * May also be synthesized from trackball motions. */
#define  KEYCODE_DPAD_RIGHT       22
/** Key code constant: Power key. */
#define  KEYCODE_POWER            26
/** Key code constant: '.' key. */
#define  KEYCODE_PERIOD           56
/** Key code constant: Enter key. */
#define  KEYCODE_ENTER            66
/** Key code constant: Menu key. */
#define  KEYCODE_MENU             82


#endif /* ESCommandCode_h */
