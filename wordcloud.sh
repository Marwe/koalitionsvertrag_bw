#!/bin/bash

if [ -z "$(which wordcloud_cli)" ] ;then
    echo "install wordcloud first, e.g. with"
    echo "mkvirtualenf wordcloud"
    echo "pip3 install wordcloud"
    exit 1
fi
tmpf="$(mktemp)"
#dialog --radiolist "select .md file" 16 70 10 $(find . -maxdepth 0 -type f -name '*.md' | awk 'BEGIN{chk="on "}{printf " "$0" \"" $0 "\" " chk;chk="off "}') 2>"$tmpf"
#lbl=$(<"$tmpf")
ifile=$(dialog --stdout --title "Please choose input text file" --fselect ./ 30 70)
echo "filesection: $ifile"
if [ -z "$ifile" ] ; then
    exit 1
fi

if [ ! -d "stopwords-de" ] ; then
    read -p "checkout stopwords via git clone https://github.com/stopwords-iso/stopwords-de.git ? [y/N]" ans
    if [ "$ans" == "y" ] ; then
        git clone https://github.com/stopwords-iso/stopwords-de.git
    fi
fi
if [ ! -f "stopwords" ] ; then
    cat ./stopwords_de_koalitionsvertrag.txt ./stopwords-de/raw/stop-words-german.txt ./stopwords-de/raw/language-resource-stopwords.txt ./stopwords-de/raw/stopwords-filter-de.txt > stopwords
fi

wordcloud_cli --text "$ifile" --stopwords "stopwords" --imagefile "wordcloud_$(basename ${ifile}).png" --width 1200 --height 600

