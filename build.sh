#!/bin/sh

fd -e html | while read file; do
    echo $file
done

