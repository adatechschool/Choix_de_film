require 'csv'

table = CSV.read("a_voir.csv")

x = table.length
x -= 1
y = rand(0..x)
puts table[y][0]
table[y].delete_at(0)

if table[y].length == 0
	table.delete_at(y)
end
y = 0
table.each do |item|
	table[y].each do |x|
		print "#{x}"
	end
	puts ""
	y += 1
end

CSV.open("a_voir.csv", "w") do |csv|
	table.each do |item| 
		csv << item
	end
end
