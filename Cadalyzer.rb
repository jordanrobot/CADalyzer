#!/usr/bin/env ruby

##################################
###      CADalyzer 0.3         ###
###     Matthew D. Jordan      ###
###    www.scenic-shop.com     ###
### shared under the GNU GPLv3 ###
##################################

# user variables
wordlist = "command_list.txt"
path = "/Users/ra/Documents/Sandbox/Ruby/CADalyzer-support/logs 2"
show_unused_commands = false
write_compiled = false
write_results = false

# set some stuff
require "date"
require "time"
working = Dir.pwd
tempfile = String.new
count = Hash.new
$stderr.reopen $stdout

# change the currently working path to the script directory

starting_path = $0.to_s.chomp("Cadalyzer.rb")

Dir.chdir(starting_path)


ARGV.each do |a|
  if a == "u"
    show_unused_commands = true
  end
  if a == "c"
    write_compiled = true
  end
  if a == "r"
    write_results = true
  end
end

################################
### check for required files ###
################################

if not File.exist?(wordlist)
  puts "Please enter a valid path to the wordlist:"
  wordlist = gets.chomp
end

if not File.exist?(path)
  puts "Please enter a valid path to the log files:"
  path = gets.chomp
end

# Copy wordlist to hash
IO.read(wordlist).split.each do |i|
  count[i] = 0
end

#########################
### Compile Log Files ###
#########################

# TODO: @Add option to use most recent cached log file (won't recompile)

#reads log files from "path" directory and appends them to the string "tempfile"
Dir.chdir(path)
Dir.glob( '*.log' ).each do |i|
  File.open( i, 'r' ) do |i|
    tempfile << i.readlines.to_s
  end
end


###############################
### Write Compiled Log File ###
###############################

if write_compiled == true
  #Writes the tempfile var to the compiled logs file
  File.open("compiled.txt", 'w') do |f|
    f.write tempfile
  end
  puts "Compiled logs have been saved to disk"
end


########################
### Counting Objects ###
########################

# TODO: @more efficient counting methods??
Dir.chdir(working)
tempfile.each_line do |line|
  words = line.split
  words.each do |w|
    if count.has_key?(w)
      count[w] += 1
    end
  end
end

# delete keys from hash that do not have values
if show_unused_commands == false
  count.delete_if {|key, value| value == 0 }
else   count.delete_if {|key, value| value != 0 }
end

# sort & print results
count.sort{|a,b| b[1]<=>a[1]}.each do |v|
  puts "#{v[1]}, #{v[0]}"
end
puts "Number of commands used: " + count.length.to_s

# save results to disk
if write_results == true
  open('results.txt', 'w') do |file|
    file.puts "CADalyzer results calculated at " + Time.new.to_s + "\n\n"
    count.sort{|a,b| b[1]<=>a[1]}.each do |v|
      file.puts "#{v[1]}, #{v[0]}"
    end
  end
  puts "Results have been saved to disk"
end
