# NetLinx ERB

netlinx-erb

A code generation utility for AMX NetLinx control systems.

[![Gem Version](https://badge.fury.io/rb/netlinx-erb.svg)](http://badge.fury.io/rb/netlinx-erb)
[![API Documentation](http://img.shields.io/badge/docs-api-blue.svg)](http://www.rubydoc.info/gems/netlinx-erb)

Syntax highlighting is included in [sublime-netlinx](https://github.com/amclain/sublime-netlinx).


## Overview

Use a descriptive syntax...
[ERB Template](screenshots/example_erb.png)

To generate repetative NetLinx code...
[Generated AXI File](screenshots/example_axi.png)

With netlinx-erb, configuration is separated from implementation. For example,
touch panel button numbers and video inputs (configuration) are separated from
the code that handles video patching when a button is pressed (implementation).
Under this paradigm, reconfiguration can happen quickly as project requirements
change. Since the implementation code is separated from these changes and code
generation is automated, there is less chance of inducing bugs into the system
when a change in configuration happens.

For example, in the code above, let's say the client decides to add a camera
to the system. All we have to do to update this file is add the following to
the `video_sources` hash:

```ruby
    BTN_VID_CAMERA: { btn: 14, input: :VID_SRC_CAMERA }
```

This defines a new touch panel button constant `BTN_VID_CAMERA`, assigns that
constant to channel number `14`, and adds a case to the button event handler
to switch the video matrix to `VID_SRC_CAMERA` when the button is pressed.
Since the implementation code for this change is auto-generated, and we know
that the implementation code works correctly, it is unlikely that this change
will create any bugs. There is a clear advantage to this method as the amount
of code grows and the project becomes more complex.


## Installation

## Issues, Bugs, Feature Requests

Any bugs and feature requests should be reported on the GitHub issue tracker:

https://github.com/amclain/netlinx-erb/issues


**Pull requests are preferred via GitHub.**

Mercurial users can use [Hg-Git](http://hg-git.github.io/) to interact with
GitHub repositories.


## Prerequisite Knowledge

## Getting Started

## Code Examples
