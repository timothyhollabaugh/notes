#!/bin/bash

LOG=log

tail -f $LOG | awk '
    $1 == 0 { print > "samples"; close("samples") }
    $1 != 0 { print >> "samples"; close("samples") } '


