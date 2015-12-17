prefix = /usr/local
confdir = /etc/sysreporter
bindir = $(prefix)/bin
sharedir = $(prefix)/share
mandir = $(sharedir)/man
man1dir = $(mandir)/man1
destbin = $(DESTDIR)$(bindir)
destconf = $(DESTDIR)$(confdir)
destreportsdir = $(destconf)/reports.d

all:
# noop

.PHONY: install
install: sysreport
# Make destination directories if needed
	$(shell [ ! -d $(destconf) ] && mkdir -p $(destconf))
	$(shell [ ! -d $(destbin) ] && mkdir -p $(destbin))

	install sysreport $(destbin)

# Install and setup configuration file
	install -m644 -T sysreporter.conf.sample $(destconf)/sysreporter.conf
	@echo "export REPORTSDIR=\"$(confdir)/reports.d\"" >> $(destconf)/sysreporter.conf
	@echo "export TEMPDIR=\"/tmp/sysreporter\"" >> $(destconf)/sysreporter.conf

# Install and enable default reports
	install -d $(destreportsdir)
	install -m644 -D reports.d/* $(destreportsdir)
	chmod +x $(destreportsdir)/3*
