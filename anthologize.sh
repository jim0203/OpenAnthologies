#!/bin/bash

# Create the file we're going to use for our final LaTeX output
timestamp=`date +%s`
project="Blake-OA-Example-"
filename="$project$timestamp"
filename+=".tex"

touch $filename

cat CommonDriver-OA.tex >> $filename

echo >> $filename
echo >> $filename

cat Driver-Blake.tex >> $filename

echo >> $filename
echo >> $filename

for file in "$@"
do
    textinputline="\\input{\""
    textinputline+=$file
    textinputline+="\"}"
    echo $file
    echo $textinputline >> $filename
done

echo >> $filename
echo "\\end{document}" >> $filename

echo $filename

latex $filename
pdflatex $filename

pdffile="$project$timestamp"
pdffile+=".pdf"

open $pdffile