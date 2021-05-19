#!/bin/sed -f

# replace the 3 lines before single (=page) number on a line
# adapted from https://stackoverflow.com/a/11795844
/\n/!N
/\n.*\n/!N
/\n.*\n[0-9]\+$/{$d;d}
P
D

