# TODO - not saving results.txt

#!/usr/bin/env ruby

##################################
###      CADalyzer 0.54b       ###
###     Matthew D. Jordan      ###
###    www.scenic-shop.com     ###
### shared under the GNU GPLv3 ###
##################################

=begin
command line options
  unused    -shows only unused commands
  compile   -saves a compiled log to disk
  results   -saves the results to disk
  percent   -shows the results as percentage of the total number of command uses
=end


#Path to log file directory
path = '/Users/ra/Sandbox/Ruby/CADalyzer/logs'


# non-user variables
command_list = $0.to_s.chomp("Cadalyzer.rb") + "command_list.txt"

show_results = true
show_percent = false
write_compiled = false
write_results = false
show_unused = false

working = Dir.pwd
tempfile = String.new
count = Hash.new
$stderr.reopen $stdout
@uber_total = 0

ARGV.each do |a|
  if a == "unused"
    show_unused = true
  end
  if a == "compile"
    write_compiled = true
  end
  if a == "results"
    write_results = true
  end
  if a == "percent"
    show_percent = true
  end
end


################################
### check for required files ###
################################

if not File.exist?(command_list)
  puts "Please puts the command_list.txt file in the same folder as this script & run script again."
end


# Copy command_list to hash
IO.read(command_list).split.each do |i|
  count[i] = 0
end

if not File.exist?(path)
  puts "Please enter a valid path to the log files:"
  path = gets.chomp
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


#count the uber total of commands
count.each {|k,v| @uber_total = @uber_total + v  }

#divide the values in the hash "count" by the @uber_total
#store the values back into the hash

if show_percent == true
  count.each do |k,v|
    count[k] = v.to_i * 100 / @uber_total.to_i 
  end
    puts "Commands as a % of the total commands executed:\n\n"
  else
    puts "Count of commands:\n\n"
end


# Show Unused Commands Switch
# delete keys from hash that do not have values
if show_unused == true
  count.delete_if {|key, value| (value != 0) }
else   count.delete_if {|key, value| value <= 0 }
end


# show results
if show_results == true  
  count.sort{|a,b| b[1]<=>a[1]}.each do |v|
    puts "#{v[1]}, #{v[0]}"
  end
end

  puts "\nNumber of commands listed: " + count.length.to_s

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

puts ""
puts "Total number of command executions: #{@uber_total}"