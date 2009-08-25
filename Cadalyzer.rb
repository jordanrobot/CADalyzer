#!/usr/bin/env ruby

################################
# CADalyzer 0.1
# Matthew D. Jordan
# www.scenic-shop.com
# shared under the GNU GPLv3
################################

# Set initial vaiables
path = "/Users/ra/Documents/Sandbox/Ruby/CADalyzer-support/logs 2"

################################

working = Dir.pwd
wordlist = "command_list.txt"
compiled_log_file = "compiled"
tempfile = String.new
count = Hash.new

###############################

#require "date"
#require "time"

$stderr.reopen $stdout

################################
######## Filcheck def ##########
################################

#makes sure the user enters text at the prompts

#def filecheck(file, name)
#  count = 0
#  while file.length <= 1 do
#    count += 1
#    exit if count == 3
#    puts "Enter " + name + ":"
#    file = gets.strip
#  end
#  return file
#end


################################
###### Compile Log Files #######
################################

# TODO: @exclude compiled log files from log file compilation
# TODO: @Add option to use most recent cached log file (won't recompile)
# TODO: @Add option to save a log compilation to a file


#reads log files from "path" directory and appends them to the string "tempfile"
Dir.chdir(path)
Dir.glob( '*.log' ).each do |e|
  File.open( e, 'r' ) do |i|
    tempfile << i.readlines.to_s
  end
end


################################
### Write Compiled Log File ####
################################

#run filecheck on compiled_log_file & path
#compiled_log_file = filecheck(compiled_log_file, 'name for new log file')
#path = filecheck(path, 'path to logs files')

#Connecates the full file name for the compiled log file
#log_appendage = Time.new.strftime("%j-%H.%M.%S")
#compiled_log_file = "compiled." + log_appendage + ".log"

#Writes the tempfile var to the compiled logs file
#File.open(compiled_log_file, 'w') do |f|
#  f.write tempfile
#end

p "Compiled logs"

###############################
###### Counting Objects #######
###############################

# TODO: @more efficient counting methods

Dir.chdir(working)

IO.read(wordlist).split.each do |l|
xxx = Regexp.new(l)
array = tempfile.scan(/^\b#{xxx}\b/).size
  if array != 0;
    then
    count[l] = array
  end
end

# TODO: @get rid of visual scroll of counting

#print results
count.sort{|a,b| b[1]<=>a[1]}.each { |v|
  puts "#{v[1]}, #{v[0]}"
  }
#p count