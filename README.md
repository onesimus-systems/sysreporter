SysReporter
===========

SysReporter is a bash script that runs and aggregates a set of reports about its host server. The report can then be emailed to the system administrator on a daily, hourly, minutely basis.

Requirements
------------

* ssmtp (if emailing is enabled)
* sysstat (if using the DiskCPUio, processStats, or sar reports)

Install - Manually
------------------

1. Download the source and extract it to a place of your choosing.
2. Copy the sample config file to `sysreporter.conf`. The file may be in the same folder as the main script or in `/etc/sysreporter`. A config in the same directory will be used over one in etc.
3. Edit sysreporter.conf and set the settings to your liking. The EMAIL_TO field must be set to send email. Addresses are separated by a comma.
4. Install and setup ssmtp if you would like to receive the reports via email.
5. Setup a cron job to run periodically.
6. The default reports `31-DiskCPUio`, `35-processStats`, and `36-sar` require the sysstat package. If this package is not installed the reports won't run. If you want to use any of these reports follow these instructions:
	- Install the sysstat package
	- Edit /etc/default/sysstat and change ENABLED to true
	- Run "sudo service sysstat restart"
	- These reports may be disabled, however even if enabled they will check for the presence of their respective commands before executing. You will see a message for that report indicating the package doesn't exists.

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

Reports
-------

Reports are located in the reports.d folder. Reports must be executable. Unexecutable files will be ignored as well as files that don't match the FILTER setting. The executable may be anything including a shell script, php/perl/ruby/etc script, or even a binary. Reports must print their heading and body to standard output which will be taken by the aggregator. The first line will be interpreted as the report header, the remaining will be the report body. An empty line between the header and body is not necessary. See the default reports for examples. Reports are executed in alphabetical order. To ensure a particular order it's recommended to use a numbered prefix such as 10-Report.sh, 20-Report2.sh. This will ensure correct order.

The location of the reports.d directory when installed via an OS package will normally be at `/etc/sysreporter/reports.d`. Otherwise it will typically be in the same folder as the main script. The location is configurable in the configuration file.

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
