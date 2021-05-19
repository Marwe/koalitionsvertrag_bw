#!/bin/sed -f

# replace all possible wordwrap dashes with a placeholder
s/- /|/g
# undo for und/oder
s/|und /- und /g
s/|oder /- oder /g
s/Baden|Württemberg/Baden-Württemberg/g
# replace remaining placeholders
s/|//g
