prefix = /usr/local
confdir = /etc/sysreporter
bindir = $(prefix)/bin
man1dir = $(prefix)/share/man/man1
destbin = $(DESTDIR)$(bindir)
destconf = $(DESTDIR)$(confdir)
destreportsdir = $(destconf)/reports.d
destman = $(DESTDIR)$(man1dir)

all:
# noop

.PHONY: install
install: sysreport
# Make destination directories if needed
	$(shell [ ! -d "$(destconf)" ] && mkdir -p "$(destconf)")
	$(shell [ ! -d "$(destbin)" ] && mkdir -p "$(destbin)")
	$(shell [ ! -d "$(destman)" ] && mkdir -p "$(destman)")

	install sysreport "$(destbin)"

# Install and setup configuration file
	install -m644 -T sysreporter.conf.sample "$(destconf)/sysreporter.conf"
	@echo "REPORTSDIR=\"$(confdir)/reports.d\"" >> "$(destconf)/sysreporter.conf"
	@echo "TEMPDIR=\"/tmp/sysreporter\"" >> "$(destconf)/sysreporter.conf"

# Install and enable default reports
	install -d "$(destreportsdir)"
	install -m644 -D reports.d/* "$(destreportsdir)"
	install -D reports.d/3* "$(destreportsdir)"

# Install manpage
	install -m644 sysreport.1 "$(destman)"
