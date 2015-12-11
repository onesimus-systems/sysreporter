SysReporter
===========

SysReporter is a bash script that runs and aggregates a set of reports about its host server. The report can then be emailed to the system administrator on a daily, hourly, minutely basis.

Requirements
------------

* ssmtp (if emailing is enabled)
* sar (if using the default system activity report)

Install
-------

* Move the SysReporter directory to a place of your choosing
* Move sysreporter.conf to /etc
* Edit /etc/sysreporter.conf and fill in the server name variable and the email addresses to send the report (separated by comma).
* Install and setup ssmtp if you would like to receive the reports via email
* Setup a cron job to run periodically
* The default set of reports includes one called "sar" (System Activity Report) which requires the sysstat package. If this package is not installed the report won't run. If you want to use sar follow these instructions:
    - Install the sysstat package
    - Edit /etc/default/sysstat and change Enabled to true
    - Run "sudo service sysstat restart"
    - sar is completely optional, it will not affect other reports

Usage
-----

report.sh [command] [arguments]

Commands:
    - run - Run a full report and email if enabled
    - show - Show reports that will be ran
    - enable - Enable a set of reports `report.sh enable 41` or `report.sh enable apache`
    - disable - Disable a set of reports, same syntax as enable
    - help - Show usage
    - version - Show version

Reports
-------

Reports are located in the reports.d folder. Reports must be executable. Unexecutable files will be ignored as well as files without the .sh extension. The script may invoke any other program or shell but must accept at least two arguments. Argument 1 is the filename of the reporter script. Argument 2 is either "header" or "body". When invoked with "header", the script should print to standard output the header of the report. Likewise when invoked with "body" it should print the main part of the report. Everything printed to standard output will be included in the report. See the default reports for examples. Reports are executed in the alphabetical order. To ensure a particular order it is recommended to use a numbered prefix such as 10-Report.sh, 20-Report2.sh. This will ensure correct order.

Default Reports (30s)
---------------------

* Currently logged in users
* CPU/Disk IO
* Disk usage
* Last boot time
* Last 10 logged in users
* Process statistics
* System activity report (sar)
* Syslog tail

Extra Reports (40s)
-------------------

* Elasticsearch log tail
    - You will need to change the file name of the log file
* Apache access log tail
* Apache error log tail
* Nginx access log tail
* Nginx error log tail

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
