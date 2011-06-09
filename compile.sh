#!/bin/sh

cd po

for i in `ls *.po|sed "s/\.po//"`; do
	echo "Compiling $i..."
	msgfmt $i.po -o $i.mo
done

cd ..

intltool-merge po/ -d -u gmountman.desktop.in gmountman.desktop

