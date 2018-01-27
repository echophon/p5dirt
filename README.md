# p5dirt
Thingie for echoing superdirt parameters to processing + additional thingie for echoing to VDMX

# Overview
TidalCycles is a live-coding language for creating patterns. It is generally used in conjunction with SuperCollider to make
sounds & music.  

Patterns can be visual too!  This updates yaxu's example to send OSC to P5 with some additional processing to echo OSC so that
VDMX can receive it.

When the OSC is output from TidalCycles, it sends key/value pairs in a list like below.

```
***************
/play2 : (
    "<OSCVal s \"num1\">",
    "<OSCVal f 0.000000>",
    "<OSCVal s \"num2\">",
    "<OSCVal f 0.300000>",
    "<OSCVal s \"s\">",
    "<OSCVal s \"bd\">"
)
```

VDMX can parse the message from the list, but it doesn't know about the key/value pairs, so you have to specify an index to 
grab the value you want.  When live-coding this is problematic as you'll likely want to send different values at different times.

The processing code is extended so that the msgs are parsed and sent as individual messages, which makes for easier use in VDMX,
the output will look more like below.

```
***************
/num1 : <OSCVal f 0.000000>

***************
/num2 : <OSCVal f 0.300000>

```
