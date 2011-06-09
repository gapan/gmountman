#!/bin/sh

cd po

for i in `ls *.po|sed "s/\.po//"`; do
	echo "Compiling $i..."
	msgfmt $i.po -o $i.mo
done

cd ..

intltool-merge po/ -d -u gmountman.desktop.in gmountman.desktop

if [ -x $( which txt2tags ) ]; then
	cd man
	txt2tags gmountman.t2t
	cd ..
else
	echo "WARNING: txt2tags is not installed. The gmountman manpage will not be created."
fi

