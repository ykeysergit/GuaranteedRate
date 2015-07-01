require_relative 'parser'
require_relative 'record'
require_relative 'sort_proxy'
require_relative 'gender_comparator'
require_relative 'last_name_comparator'
require_relative 'dob_comparator'

print 'What file would you like to parse? '
file_path=$stdin.readline.chomp
records=Parser.new.parse_file(file_path)

puts "Output 1"
puts SortProxy.new(records,[GenderComparator.new, LastNameComparator.new(LastNameComparator::ASC)]).sort!
puts

puts "Output 2"
puts SortProxy.new(records,[DOBComparator.new]).sort!
puts

puts "Output 3"
puts SortProxy.new(records,[LastNameComparator.new(LastNameComparator::DESC)]).sort!
puts


