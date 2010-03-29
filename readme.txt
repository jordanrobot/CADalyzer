CADalyzer
=========

A stupid little utility to parse your AutoCAD log files
and count the commands you have been using.

Usage:
------
	Cadalyzer.rb <option>

Options:
--------
  - `unused`  - show unused commands
  - `compile` - save the compiled dataset to a file
  - `write`   - save the results to a file
  - `percent` - show commands in terms of relative percentages
  - `help`    - this screen here!


TODO
----
* `head <#>` option - show the top # of commands
* `time` option - show the delta percentages of commands over time 
* not outputting results.txt correctly - fix
* output to a CVS format?
* keep track of timestamps? - to track command usage over time
* more efficient parsing & counting?
* output information to a graphical format - html based graphs?


Benchmarks
==========

v 0.7
-----
Analysis of "logs" folder (100 mb)

mean run time = 15 seconds

v 0.6
-----
Analysis of "logs" folder (100 mb)

mean run time = 22.4 seconds