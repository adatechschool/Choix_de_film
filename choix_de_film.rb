require 'csv'

#puts Dir.pwd

#puts File.expand_path File.dirname(__FILE__)

file = "#{File.expand_path File.dirname(__FILE__)}/a_voir.csv"

table = CSV.read(file)

x = table.length
x -= 1
y = rand(0..x)
puts table[y][0]

movie = table[y][0]
table[y].delete_at(0)

if table[y].length == 0
	table.delete_at(y)
end
y = 0
table.each do |item|
	table[y].each do |x|
		print "#{x} "
	end
	puts ""
	y += 1
end

CSV.open(file, "w")  do |csv|
  table.each do |item|
    csv << item
  end
end

CSV.open("#{File.expand_path File.dirname(__FILE__)}/vu.csv", "a") do |csv|
	csv << [movie]
end
