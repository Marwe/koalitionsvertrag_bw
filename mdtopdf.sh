#!/bin/bash

function mdpdf(){
outf="${1}.pdf"
echo "processing $1 -> $outf"
pandoc --toc -V classoption:DIV21 -V colorlinks:true -V documentclass:scrartcl --pdf-engine=xelatex -V lang=de -V classoption:ngerman -fmarkdown+autolink_bare_uris+lists_without_preceding_blankline+subscript+inline_notes -o "$outf" "$1"

}

if [ -z "$1" ] ; then
for i in *.md
do
    mdpdf "$i"
done
else
    mdpdf "$1"
fi

