#!/bin/sh

xgettext --from-code=utf-8 \
	-L Glade \
	-o po/gmountman.pot \
	src/gmountman.glade

xgettext --from-code=utf-8 \
	-j \
	-L Python \
	-o po/gmountman.pot \
	src/gmountman

intltool-extract --type="gettext/ini" gmountman.desktop.in
xgettext --from-code=utf-8 -j -L C -kN_ -o po/gmountman.pot gmountman.desktop.in.h
rm gmountman.desktop.in.h

cd po
for i in `ls *.po`; do
	msgmerge -U $i gmountman.pot
done
rm -f ./*~

