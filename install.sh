#!/bin/sh

install -d -m 755 $DESTDIR/usr/bin
install -d -m 755 $DESTDIR/usr/share/applications
install -d -m 755 $DESTDIR/usr/share/gmountman
install -m 755 src/gmountman $DESTDIR/usr/bin/
install -m 644 src/gmountman.glade $DESTDIR/usr/share/gmountman/
install -m 644 gmountman.desktop $DESTDIR/usr/share/applications/

for i in 32 24 22 16; do
	install -d -m 755 \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/apps/ \
	2> /dev/null
	install -m 644 icons/gmountman-$i.png \
	$DESTDIR/usr/share/icons/hicolor/${i}x${i}/apps/gmountman.png
done
install -d -m 755 $DESTDIR/usr/share/icons/hicolor/scalable/apps
install -m 644 icons/gmountman.svg \
$DESTDIR/usr/share/icons/hicolor/scalable/apps

for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do
	install -d -m 755 $DESTDIR/usr/share/locale/$i/LC_MESSAGES
	install -m 644 po/$i.mo $DESTDIR/usr/share/locale/$i/LC_MESSAGES/gmountman.mo
done
