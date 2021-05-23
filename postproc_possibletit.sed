#!/bin/sed -f

# Add 3rd level header to all lines not ending in . or :
# manually join lines, then get rid of excess ones
s|^[^#\*].*[^\.:]$|### &|
