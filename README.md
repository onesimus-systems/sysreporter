SysReporter
===========

SysReporter is a bash script that runs and aggregates a set of reports about its host system. The report can then be emailed to the system administrator on a daily, hourly, minutely basis.

Requirements
------------

* ssmtp (if emailing is enabled)
* sysstat (if using the DiskCPUio, processStats, or sar reports)

Install - Package Manager
-------------------------

Linux distro packages are available for Ubuntu, Fedora, Red Hat Enterprise Linux (RHEL), and CentOS. This is the easiest way to install sysreporter but these package may be outdated compared to the source. Typically this isn't an issue.

Ubuntu:

```bash
$ sudo add-apt-repository ppa:lfkeitel/sysreporter
$ sudo apt-get update
$ sudo apt-get install sysreporter
```

Fedora:

```bash
$ dnf install sysreporter
```

RHEL/CentOS:

```bash
$ yum install http://download.fedoraproject.org/epel/epel-release-latest-7.noarch.rpm  For RHEL/CentOS 7 (if EPEL is not already installed)
$ yum install http://download.fedoraproject.org/epel/epel-release-latest-6.noarch.rpm  For RHEL/CentOS 6 (if EPEL is not already installed)
$ yum install sysreporter
```

Install - Automatic - Source
----------------------------

1. Download and extract the latest release source
2. Run `sudo make install`
3. That's it. The `sysreport` command should now be available. Configuration and reports are located at `/etc/sysreporter`. To learn how to use it, run `man sysreport`.

Install - Portable - Source
---------------------------

1. Download the source and extract it
2. Copy the sample config file to `sysreporter.conf`
3. Edit sysreporter.conf and set the settings to your liking. The EMAIL_TO field must be set to send email. Addresses are separated by a comma. Eg. `email@example.com, email2@example.com`.

Usage
-----

sysreport [command] [arguments]

Commands:

- `run` - Run a full report and email if enabled
	- Arguments:
		- `stdout` - Print the full report to standard output. Will not send an email.
		- `email` - Default, if no argument is given this is implied. Will compile a report as usual and email if email is enabled.
- `show` - Show enabled and disabled reports
- `enable` - Enable a set of reports `sysreport enable 41` or `sysreport enable apache`
- `disable` - Disable a set of reports, same syntax as enable
- `help` - Show usage
- `version` - Show version

Reports may require root/elevated privileges to run. Make sure `sysreport` is ran from a user with these privileges.

Setup Email
-----------

Sysreporter by default uses `ssmtp` for email. If you wish to receive email you'll need to install and setup that package. Please refer to ssmtp's documentation for details.

Setup Cron
----------

A simple way to use sysreporter is to setup ssmtp and setup a cron job to run periodically. The easiest way to set that up is to use crontab by running `crontab -e` and adding the line `* 9 * * * /usr/bin/sysreport run email >/dev/null 2>&1`. This job will email a report everyday at 9:00a.

Setup sysstat
-------------

The default reports `31-DiskCPUio`, `35-processStats`, and `36-sar` require the sysstat package. If this package is not installed the reports won't run. If you want to use any of these reports follow these instructions below.

1. Install the sysstat package using your distro's package manager
2. Enable data collection using one of the following methods:
	- Ubuntu: Edit `/etc/default/sysstat` and change ENABLED to true
	- Fedora: Run `sudo systemctl enable sysstat.service`
	- Other: Check for the sysstat config file and if it doesn't exist and your system uses systemd, use the Fedora instructions. Ubuntu versions that use systemd still use the old config file method.
3. Restart the sysstat service:
	- Ubuntu: `sudo service sysstat restart`
	- Fedora: `sudo systemctl start sysstat.service`

It will take some time for sysstat to capture data. After a few hours to a day it'll have collected a good chunk of data to look at.

Reports
-------

Reports are located in the reports.d folder. Reports must be executable. Unexecutable files will be ignored as well as files that don't match the FILTER setting. The executable may be anything including a shell script, php/perl/ruby/etc script, or even a binary. Reports must print their heading and body to standard output which will be taken by the aggregator. The first line will be interpreted as the report header, the remaining will be the report body. An empty line between the header and body is not necessary. See the default reports for examples. Reports are executed in alphabetical order. To ensure a particular order it's recommended to use a numbered prefix such as 10-Report.sh, 20-Report2.sh. This will ensure correct order.

The location of the reports.d directory when installed via an OS package will normally be at `/etc/sysreporter/reports.d`. Otherwise it will typically be in the same folder as the main script. The location is configurable in the configuration file. You can check the location by running `sysreport show`.

Default Reports (30s)
---------------------

* Currently logged in users
* CPU/Disk IO (sysstat)
* Disk usage
* Last boot time
* Last 10 logged in users
* Process statistics (sysstat)
* System activity report (sysstat)
* Last 25 syslog messages

Reports marked with "sysstat" require that package to run.

Extra Reports (40s)
-------------------

* Elasticsearch log tail
	- You will need to change the file name of the log file
* Apache access log tail
* Apache error log tail
* Nginx access log tail
* Nginx error log tail
* NTP statistics (ntpq, ntpstat)

License
-------

Copyright (c) 2015 Lee Keitel <lee@onesimussystems.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
