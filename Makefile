PREFIX ?= /usr/local
DESTDIR ?= /
PACKAGE_LOCALE_DIR ?= /usr/share/locale

.PHONY: all
all: mo desktop

.PHONY: mo
mo:
	for i in `ls po/*.po`; do \
		msgfmt $$i -o `echo $$i | sed "s/\.po//"`.mo; \
	done

.PHONY: desktop
desktop:
	intltool-merge po/ -d -u \
		gmountman.desktop.in gmountman.desktop

.PHONY: updatepo
updatepo:
	for i in `ls po/*.po`; do \
		msgmerge -UNs $$i po/gmountman.pot; \
	done
	rm -f po/*~

.PHONY: pot
pot:
	xgettext --from-code=utf-8 \
		-L Glade \
		-o po/gmountman.pot \
		src/gmountman.ui
	xgettext --from-code=utf-8 \
		-j \
		-L Python \
		-o po/gmountman.pot \
		src/gmountman
	intltool-extract --type="gettext/ini" \
		gmountman.desktop.in
	xgettext --from-code=utf-8 -j -L C -kN_ \
		-o po/gmountman.pot gmountman.desktop.in.h
	rm -f gmountman.desktop.in.h

.PHONY: clean
clean:
	rm -f po/*.mo
	rm -f po/*.po~
	rm -f gmountman.desktop

.PHONY: install
install: install-icons install-mo
	install -d -m 755 $(DESTDIR)/usr/bin
	install -d -m 755 $(DESTDIR)/usr/share/applications
	install -d -m 755 $(DESTDIR)/usr/share/gmountman
	install -m 755 src/gmountman $(DESTDIR)/usr/bin/
	install -m 644 src/gmountman.ui $(DESTDIR)/usr/share/gmountman/
	install -m 644 gmountman.desktop $(DESTDIR)/usr/share/applications/

.PHONY: install-icons
install-icons:
	install -d -m 755 $(DESTDIR)/usr/share/icons/hicolor/scalable/apps/
	install -m 644 icons/gmountman.svg \
		$(DESTDIR)/usr/share/icons/hicolor/scalable/apps/
	for i in 32 24 22 16; do \
		install -d -m 755 \
		$(DESTDIR)/usr/share/icons/hicolor/$${i}x$${i}/apps/ \
		2> /dev/null; \
		install -m 644 icons/gmountman-$$i.png \
		$(DESTDIR)/usr/share/icons/hicolor/$${i}x$${i}/apps/gmountman.png; \
	done

.PHONY: install-mo
install-mo:
	for i in `ls po/*.po|sed "s/po\/\(.*\)\.po/\1/"`; do \
		install -d -m 755 $(DESTDIR)/usr/share/locale/$$i/LC_MESSAGES; \
		install -m 644 po/$$i.mo $(DESTDIR)/usr/share/locale/$$i/LC_MESSAGES/gmountman.mo; \
	done

