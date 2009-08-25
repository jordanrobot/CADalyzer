#!/usr/bin/env ruby

##############################
#      CADalyzer 0.2         #
#     Matthew D. Jordan      #
#    www.scenic-shop.com     #
# shared under the GNU GPLv3 #
##############################

# Set initial vaiables
path = "/Users/ra/Documents/Sandbox/Ruby/CADalyzer-support/logs 2"
working = Dir.pwd
wordlist = "command_list.txt"
tempfile = String.new
count = Hash.new

#switches
show_unused_commands = false
write_compiled = false
write_results = false

require "date"
require "time"

###############################

$stderr.reopen $stdout

if not File.exist?(wordlist)
wordlist = gets
end

if not File.exist?(path)
path = gets
end

# Copy wordlist to hash
IO.read(wordlist).split.each do |i|
  count[i] = 0
  end


################################
###### Compile Log Files #######
################################

# TODO: @Add option to use most recent cached log file (won't recompile)

#reads log files from "path" directory and appends them to the string "tempfile"
Dir.chdir(path)
Dir.glob( '*.log' ).each do |i|
  File.open( i, 'r' ) do |i|
    tempfile << i.readlines.to_s
  end
end

################################
### Write Compiled Log File ####
################################

if write_compiled == true
  #Writes the tempfile var to the compiled logs file
  File.open("compiled.txt", 'w') do |f|
    f.write tempfile
  end
    puts "Compiled logs have been saved to disk"
end  

###############################
###### Counting Objects #######
###############################

# TODO: @more efficient counting methods??

Dir.chdir(working)
tempfile.each_line do |line|
  words = line.split
  words.each do |w|
    if count.has_key?(w)
      count[w] = count[w] + 1
    end
  end
end

# delete keys from hash that do not have values
if show_unused_commands == false
  count.delete_if {|key, value| value == 0 }
  else   count.delete_if {|key, value| value != 0 }
  end

# sort & print results
temp2 = count.sort{|a,b| b[1]<=>a[1]}.each do |v|
  puts "#{v[1]}, #{v[0]}"
  end

puts "Number of commands used: " + count.length.to_s

# save results to disk
# TODO: @format results written to disk
    if write_results == true
      File.open("results.txt", 'w') do |f|
        f << temp2
      end
      puts "Results have been saved to disk"
    end