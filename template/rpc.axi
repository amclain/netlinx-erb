(***********************************************************
    Remote Procedure Call (Troubleshoot by calling functions)
************************************************************)
/*---------------------------------------------------------------------------
The MIT License (MIT)

Copyright (c) 2014 Alex McLain and Joe McIlvain

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
---------------------------------------------------------------------------*/

#if_not_defined PS_RPC
#define PS_RPC 1
(***********************************************************)
(* System Type : NetLinx                                   *)
(***********************************************************)
(*           DEVICE NUMBER DEFINITIONS GO BELOW            *)
(***********************************************************)
DEFINE_DEVICE

#if_not_defined vdvRPC
// Virtual Debugging Device to receive RPC strings from user on.
// This can also be overridden in the master source code file if necessary.
vdvRPC = 34500:1:0;
#end_if

(***********************************************************)
(*              CONSTANT DEFINITIONS GO BELOW              *)
(***********************************************************)
DEFINE_CONSTANT

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


///
// User input string parsing functions

// Parse and return the name of the function from the given input string 
define_function char[255] rpc_function_name(char input[])
{
    return rpc_get_arg(0, lower_string(input));
}

// Parse and return the nth argument of the function
define_function char[255] rpc_get_arg(integer index, char input[])
{
    integer start;
    integer end;
    integer i;
    char output[255];
    
    end = 0;
    for (i = 0; i <= index; i++)
    {
        start = end;
        end = find_string(input, ' ', end+1);
    }
    
    return mid_string(input, start+1, end-start-1);
}

// Parse and return the nth argument of the function as a string (same as rpc_get_arg)
define_function char[255] rpc_get_arg_s(integer index, char input[])
{
    return rpc_get_arg(index, input);
}

// Parse and return the nth argument of the function as an integer
define_function integer rpc_get_arg_i(integer index, char input[])
{
    return atoi(rpc_get_arg(index, input));
}


///
// Output logging functions

// Print the string return value of the function call
define_function rpc_log(char output[])
{
    print(LOG_LEVEL_INFO, "'RPC function returned string: ', output");
}

// Print the string return value of the function call
define_function rpc_log_s(char output[])
{
    print(LOG_LEVEL_INFO, "'RPC function returned string: ', output");
}

// Print the integer return value of the function call
define_function rpc_log_i(integer output)
{
    print(LOG_LEVEL_INFO, "'RPC function returned integer: ', itoa(output)");
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
