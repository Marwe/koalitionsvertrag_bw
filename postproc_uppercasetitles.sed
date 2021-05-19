#!/bin/sed -f

# Add 3rd level header to all uppercase lines (no, this was not done via a caps font...)
s/^[A-ZÄÖÜ:\. -]\+$/### &/

