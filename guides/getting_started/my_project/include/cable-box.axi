(***********************************************************
    Example Cable Box
    
    For the netlinx-erb getting started project.
************************************************************)

#if_not_defined MY_PROJECT_CABLE_BOX
#define MY_PROJECT_CABLE_BOX 1
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(*           DEVICE NUMBER DEFINITIONS GO BELOW            *)
(***********************************************************)
DEFINE_DEVICE

dvCABLE = 5001:1:0;

(***********************************************************)
(*              CONSTANT DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_CONSTANT

// Cable Box Remote Control Keys
CABLE_BOX_KEY_1     = 1;
CABLE_BOX_KEY_2     = 2;
CABLE_BOX_KEY_3     = 3;
CABLE_BOX_KEY_4     = 4;
CABLE_BOX_KEY_5     = 5;
CABLE_BOX_KEY_6     = 6;
CABLE_BOX_KEY_7     = 7;
CABLE_BOX_KEY_8     = 8;
CABLE_BOX_KEY_9     = 9;
CABLE_BOX_KEY_0     = 10;
CABLE_BOX_KEY_POWER = 11;

(***********************************************************)
(*                    INCLUDES GO BELOW                    *)
(***********************************************************)

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

/*
 *  Emulate a keypress on the cable box remote control.
 */
define_function cable_box_key(integer key)
{
    pulse[dvCABLE, key];
}

(***********************************************************)
(*                 STARTUP CODE GOES BELOW                 *)
(***********************************************************)
DEFINE_START

(***********************************************************)
(*                   THE EVENTS GO BELOW                   *)
(***********************************************************)
DEFINE_EVENT

(***********************************************************)
(*                 THE MAINLINE GOES BELOW                 *)
(***********************************************************)
DEFINE_PROGRAM

(***********************************************************)
(*                     END OF PROGRAM                      *)
(*          DO NOT PUT ANY CODE BELOW THIS COMMENT         *)
(***********************************************************)
#end_if
