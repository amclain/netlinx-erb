(***********************************************************)
(*                         WARNING                         *)
(***********************************************************}
    This file was generated from the following template
    and should NOT be edited directly: 
    
      include/ui/_config.axi.erb
    
    See the documentation at `doc/index.html` for
    information about maintaining this project.
    
    Generated with netlinx-erb:
      https://github.com/amclain/netlinx-erb
{***********************************************************)

(***********************************************************
    Example Touch Panel
    
    For the netlinx-erb getting started project.
************************************************************)

#if_not_defined MY_PROJECT_TP_WALL
#define MY_PROJECT_TP_WALL 1
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(*           DEVICE NUMBER DEFINITIONS GO BELOW            *)
(***********************************************************)
DEFINE_DEVICE

dvTP_WALL = 10002:1:0;

(***********************************************************)
(*              CONSTANT DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_CONSTANT

#if_not_defined MY_PROJECT_TP_CONSTANTS
#define MY_PROJECT_TP_CONSTANTS 1

// Cable Box Buttons
BTN_CABLE_BOX_1            = 101;
BTN_CABLE_BOX_2            = 102;
BTN_CABLE_BOX_3            = 103;
BTN_CABLE_BOX_4            = 104;
BTN_CABLE_BOX_5            = 105;
BTN_CABLE_BOX_6            = 106;
BTN_CABLE_BOX_7            = 107;
BTN_CABLE_BOX_8            = 108;
BTN_CABLE_BOX_9            = 109;
BTN_CABLE_BOX_0            = 110;

#end_if

(***********************************************************)
(*                    INCLUDES GO BELOW                    *)
(***********************************************************)

#include 'cable-box'

(***********************************************************)
(*              DATA TYPE DEFINITIONS GO BELOW             *)
(***********************************************************)
DEFINE_TYPE

(***********************************************************)
(*              VARIABLE DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_VARIABLE

(***********************************************************)
(*         SUBROUTINE/FUNCTION DEFINITIONS GO BELOW        *)
(***********************************************************)

(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                   THE EVENTS GO BELOW                   *)
(***********************************************************)
DEFINE_EVENT

// Cable Box Controls
button_event[dvTP_WALL, BTN_CABLE_BOX_1]
button_event[dvTP_WALL, BTN_CABLE_BOX_2]
button_event[dvTP_WALL, BTN_CABLE_BOX_3]
button_event[dvTP_WALL, BTN_CABLE_BOX_4]
button_event[dvTP_WALL, BTN_CABLE_BOX_5]
button_event[dvTP_WALL, BTN_CABLE_BOX_6]
button_event[dvTP_WALL, BTN_CABLE_BOX_7]
button_event[dvTP_WALL, BTN_CABLE_BOX_8]
button_event[dvTP_WALL, BTN_CABLE_BOX_9]
button_event[dvTP_WALL, BTN_CABLE_BOX_0]
{
    push:
    {
        to[button.input];
        
        switch (button.input.channel)
        {
            case BTN_CABLE_BOX_1:    cable_box_key(CABLE_BOX_KEY_1);
            case BTN_CABLE_BOX_2:    cable_box_key(CABLE_BOX_KEY_2);
            case BTN_CABLE_BOX_3:    cable_box_key(CABLE_BOX_KEY_3);
            case BTN_CABLE_BOX_4:    cable_box_key(CABLE_BOX_KEY_4);
            case BTN_CABLE_BOX_5:    cable_box_key(CABLE_BOX_KEY_5);
            case BTN_CABLE_BOX_6:    cable_box_key(CABLE_BOX_KEY_6);
            case BTN_CABLE_BOX_7:    cable_box_key(CABLE_BOX_KEY_7);
            case BTN_CABLE_BOX_8:    cable_box_key(CABLE_BOX_KEY_8);
            case BTN_CABLE_BOX_9:    cable_box_key(CABLE_BOX_KEY_9);
            case BTN_CABLE_BOX_0:    cable_box_key(CABLE_BOX_KEY_0);
        }
    }
    
    release: {}
}

(***********************************************************)
(*                 THE MAINLINE GOES BELOW                 *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*          DO NOT PUT ANY CODE BELOW THIS COMMENT         *)
(***********************************************************)
#end_if
