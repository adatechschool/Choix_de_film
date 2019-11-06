require 'csv'
require 'colorize'

avoir = "#{File.expand_path File.dirname(__FILE__)}/a_voir.csv"
vu = "#{File.expand_path File.dirname(__FILE__)}/vu.csv"
table = CSV.read(avoir)

x = table.length
x -= 1
y = rand(0..x)
movie = table [y][0]
	
puts "Vous-voulez voir " + movie + " ?"
answer = gets.strip!
if answer == "oui"
	puts "Oh yeah!!!".green
	table[y].delete_at(0)
	if table[y].length == 0
		table.delete_at(y)
	end
=begin
	y = 0
	table.each do |item|
		table[y].each do |x|
			print "#{x} "
		end
		puts " "
		y += 1
	end
=end
=begin
	CSV.open(avoir, "w") do |csv|
		table.each do |item|
			csv << item
		end
	end

	CSV.open(vu, "a") do |csv|
		csv << [movie]
	end
=end
elsif answer == "non"
	puts "Poooouuuurrrqqquuuooooiiiiiiiii !!! (/;o;)/".yellow
else
	puts "(°_o) rage quit => []".red
end
exit
