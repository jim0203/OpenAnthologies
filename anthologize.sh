#!/bin/bash

source default.config

# Create the file we're going to use for our final LaTeX output
timestamp=`date +%s`
project="Blake-OA-Example-"
filename="$project$timestamp"
filename+=".tex"

touch $filename

cat CommonDriver-OA.tex >> $filename

echo >> $filename
echo >> $filename

echo "% Set the line numbering" >> $filename
echo "\setverselinemodulo{${VerseLineModule}}" >> $filename
echo "\verselinenumberstoright" >> $filename

echo >> $filename
echo "% Create the title page" >> $filename
echo "\begin{maintitlepage}" >> $filename
echo "\begin{center}" >> $filename
echo "\volumetitlefont{${Title}}" >> $filename
echo "\vskip 2em" >> $filename
echo "\volumesubtitlefont{${Subtitle}}" >> $filename
echo "\end{center}" >> $filename
echo "\end{maintitlepage}" >> $filename

echo >> $filename
echo "%Contents page and numbering" >> $filename
echo "\putpoemcontents" >> $filename
echo "\pagenumbering{arabic}" >> $filename
echo "\makepoemcontents" >> $filename

echo >> $filename

# Loop over every file in the "texts" subfolder
find "texts" -type f | while read file
do
  echo $file
  textinputline="\\input{\""
  textinputline+=$file
  textinputline+="\"}"
  echo $file
  echo $textinputline >> $filename
done

echo >> $filename
echo "\\end{document}" >> $filename

echo $filename

lualatex $filename
lualatex $filename

pdffile="$project$timestamp"
pdffile+=".pdf"

open $pdffile