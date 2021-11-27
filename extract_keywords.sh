#!/bin/bash

if [ -z "$md" ] ; then
    echo "md=210506_Koalitionsvertrag_2021-2026.md $0 $@"
    md="210506_Koalitionsvertrag_2021-2026.md"
fi

srcdir=$(dirname ${BASH_SOURCE[0]})
srcmd="$srcdir/$md"

if [ -z "$1" ] ; then
    echo 'use grep syntax like keyword1\|keyword2, better add single quotes'
    echo "current source document: $srcmd"
    echo "no keyword(s) given, exiting."
    exit 2
fi

keyletters=$(echo "$1"| sed -e 's/[^a-zA-Z]//g')
tmpfile=$(mktemp tmp.${keyletters}.$(date "+%Y-%m-%d-%H-%M").XXXX.md)

# grep all titles and keywords, then keep only one before match (max one title), then add blank lines every second line (titles, paragraphs separated)
grep -i "#\|$keyword" "$srcmd" | grep -i -B 1 "$keyword" | grep -v '^--$' | sed -e 'x;p;x;' > "$tmpfile"

"$srcdir/mdtopdf.sh" "$tmpfile"

