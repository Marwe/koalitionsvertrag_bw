# Koalitionsvertrag Ampel 2021-2025

* wget -o koalitionsvertrag-ampel-2021-2025.pdf https://www.spd.de/fileadmin/Dokumente/Koalitionsvertrag/Koalitionsvertrag_2021-2025.pdf

* conversion to md
    * convert pdf to docx via MSO
    * convert docx to md via https://word2md.com/
    * manual cleanup of `koalitionsvertrag-ampel-2021-2025.pdf.md`
        * headers level 3 were not identified (bold markup in original)
        * add markup in vi via `%s/\(^[A-Z].{4-30}[a-zA-Z][^\.]\)$/### \1/`
        * cleanup wrong ones via diff
* conversion to txt (with more things left to do - was given up)
    * Text Extraktion via tika http://givemetext.okfnlabs.org/
    * remove page numbers in kate editor (regex replace, multiline match): ´\n[\n0-9]*\n´
    * `sed -i -f postproc_sentence_newline.sed  koalitionsvertrag-ampel-2021-2025.pdf.txt´
    * manual cleanup: Headers identified and set according to contents, Title

Aufarbeitung hat CodeFreezR sehr gut gemacht, mit verschiedenen Analysen, siehe dazu den [Talk auf rc3 2021](https://pretalx.c3voc.de/rc3-2021-r3s/talk/PSEWJU/)
* Repo: [gitlab.com/mypub4u/koalas](https://gitlab.com/mypub4u/koalas), Page: [mypub4u.gitlab.io/koalas](http://mypub4u.gitlab.io/koalas/)


# Koalitionsvertrag Baden-Württemberg 2021

* source: [210506_Koalitionsvertrag_2021-2026.pdf, Download am 2021-05-19](https://www.baden-wuerttemberg.de/fileadmin/redaktion/dateien/PDF/210506_Koalitionsvertrag_2021-2026.pdf)
* Text Extraktion via tika http://givemetext.okfnlabs.org/
* postprocessing mit sed skripten

```
sed -i -f postproc_wordwrap.sed tmp.txt
sed -i -f postproc_pagenumtit.sed tmp.txt
sed -i -f postproc_uppercasetitles.sed tmp.txt
sed -i -f postproc_possibletit.sed tmp.txt
```

* manuelle Zeilenzusammenführungen
* Überschriften-Markup überarbeitet
* Kapitelüberschriften im Text ergänzt, da dort nur Subtitel als Überschriften, Extraktion aus 210506_Koalitionsvertrag_2021-2026.md

```
grep -o '^[0-9]\.\+ [^0-9]*' 
```

* zu PDF wandeln (via `pandoc`)

```
./mdtopdf.sh 210506_Koalitionsvertrag_2021-2026.md
```

* Keywords extrahieren:

```
./extract_keywords.sh 'keyword1\|keyword2' # OR, any match of the keywords
./extract_keywords.sh 'keyword1.*keyword2' # keyword1[any text]keyword2
```    

# Koalitionsvertrag Baden-Württemberg 2016

Das Dokument 160509_Koalitionsvertrag_B-W_2016-2021_final.md ist eine (pandoc-)Markdown Variante des 
*Koalitionsvertrages zwischen Bündnis 90/Die Grünen Baden-Württemberg und der CDU Baden-Württemberg 2016 - 2021*.

Der Text wurde aus dem [PDF des Koalitionsvertrages](https://www.baden-wuerttemberg.de/fileadmin/redaktion/dateien/PDF/160509_Koalitionsvertrag_B-W_2016-2021_final.PDF)
 extrahiert.
Siehe auch die Pressemeldung *Grün-schwarzer Koalitionsvertrag unterzeichnet*: https://www.baden-wuerttemberg.de/de/service/presse/pressemitteilung/pid/gruen-schwarzer-koalitionsvertrag-unterzeichnet/

Für die Extraktion kam pdftotext zum Einsatz, einige reguläre Ausdrücke und oberflächliche händische Korrekturen, vor allem der Überschriften.
Es sind sicher noch Fehler enthalten, für deren Behebung gerne Pull-Requests gestellt werden können.

## Bugs

* einige Textteile tauchen offensichtlich an falscher Stelle auf (Textfluss PDF? teilweise nach Seitenumbruch)
    * unvollständige Sätze
* Trennzeichen am Zeilenende noch enthalten
* Überschriften sind in GROSSBUCHSTABEN (Inhaltsverzeichnis am Ende zu Korrektur nutzen?)
* gefundene Probleme sind in Kommentaren markiert


## Wordclouds


![Wordcloud Koalitionsvertrag 2016](wordcloud_koalitionsvertrag_2016.png)

![Wordcloud Koalitionsvertrag 2021](wordcloud_koalitionsvertrag_2021.png)

![Wordcloud Koalitionsvertrag Ampel 2021-2025](./wordcloud_koalitionsvertrag-ampel-2021-2025.pdf.txt.png)

### creation of wordcloud

Use the script `wordcloud.sh` or use commands below

* prepare a python environment

```
mkvirtualenv wordcloud
pip3 install wordcloud
```

* get some stopword from a repo

```
git clone https://github.com/stopwords-iso/stopwords-de.git
# compile a stopwords file from a selection
cat ./stopwords_de_koalitionsvertrag.txt ./stopwords-de/raw/stop-words-german.txt ./stopwords-de/raw/language-resource-stopwords.txt ./stopwords-de/raw/stopwords-filter-de.txt > stopwords
dos2unix stopwords
```

* compute a wordcloud

```
wordcloud_cli --text 160509_Koalitionsvertrag_B-W_2016-2021_final.md --stopwords stopwords --imagefile wordcloud_koalitionsvertrag_2016.png --width 1200 --height 600
wordcloud_cli --text 210506_Koalitionsvertrag_2021-2026.md --stopwords stopwords --imagefile wordcloud_koalitionsvertrag_2021.png --width 1200 --height 600
wordcloud_cli --text ./koalitionsvertrag-ampel-2021-2025.pdf.txt --stopwords stopwords --imagefile wordcloud_koalitionsvertrag-ampel-2021-2025.pdf.txt.png --width 1200 --height 600
```

