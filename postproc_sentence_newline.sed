#!/usr/bin/sed -f

# replace any dots followed by space with dot+newline, but not for u. a. z. B. bzw. and numbers followed by a dot
s/z\. B\./_zB_/g
s/u\. a\./_ua_/g
s/bzw\./_bzw_/g
s/\.\+ /.\n/g
#s/\([^ ][uazB]\)\.\+ /\1.\n/g
s/_zB_/z. B./g
s/_ua_/u. a./g
s/_bzw_/bzw./g


